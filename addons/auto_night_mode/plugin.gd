@tool
extends EditorPlugin

# editor setting property path prefix
const prefix = "interface/auto_night_mode/"
const Consts = preload("consts.gd")

var editor_settings := get_editor_interface().get_editor_settings()

var last_theme := ""
# temporarily disable addon to prevent the signal-connected function calling itself
var disabled := false

# sun time algorithm
var sun := preload("sun.gd").new()


################################################################################
# helpers
################################################################################

func get_sunrise_hour() -> float:
	return editor_settings.get(prefix + "sunrise_time/hour")\
		+ editor_settings.get(prefix + "sunrise_time/minute") / 60.0

func get_sunset_hour() -> float:
	return editor_settings.get(prefix + "sunset_time/hour")\
		+ editor_settings.get(prefix + "sunset_time/minute") / 60.0

func get_now_theme() -> String:
	var td = Time.get_time_dict_from_system()
	var t: float = td.hour + td.minute / 60.0
	var sunrise := get_sunrise_hour()
	var sunset := get_sunset_hour()

	var sunrise_before_sunset := sunrise < sunset
	var time_gte_sunrise := (t >= sunrise and t < sunset)
	var is_day := time_gte_sunrise if sunrise_before_sunset else not time_gte_sunrise

	if is_day:
		return "day_theme"
	else:
		return "night_theme"

################################################################################
# plugin behaviours
################################################################################


func _init() -> void:
	init_missing_settings()


func _enable_plugin() -> void:
	apply_theme(get_now_theme())
	if not editor_settings.is_connected("settings_changed", Callable(self, "_settings_changed")):
		editor_settings.connect("settings_changed", Callable(self, "_settings_changed"))


func _disable_plugin() -> void:
	if editor_settings.is_connected("settings_changed", Callable(self, "_settings_changed")):
		editor_settings.disconnect("settings_changed", Callable(self, "_settings_changed"))
	if editor_settings.get_setting(prefix + "erase_settings_after_disabling"):
		for n in Consts.addon_property_defaults:
			editor_settings.erase(prefix + n)
		for theme_p in Consts.theme_properties:
			var d_p = prefix + "day_theme/" + theme_p
			editor_settings.erase(d_p)
		for theme_p in Consts.theme_properties:
			var d_p = prefix + "night_theme/" + theme_p
			editor_settings.erase(d_p)


func _settings_changed() -> void:
	if self.disabled:
		return

	if editor_settings.get(prefix + "coordinates/use_coordinates"):
		update_sun_times()

	var now_theme = get_now_theme()

	if now_theme != last_theme:
		apply_theme(now_theme)
		print(now_theme + " applied.")
	else:
		print("save ", now_theme)
		save_theme(now_theme)

	last_theme = now_theme


var last_second: int = -1
func _process(delta: float) -> void:
	if self.disabled:
		return

	var t = Time.get_time_dict_from_system()
	if t.second != last_second and t.second == 0:
		last_second = t.second
		apply_theme(get_now_theme())


################################################################################
# functions
################################################################################

# init editor settings if haven't been added
func init_missing_settings() -> void:
	self.disabled = true

	for n in Consts.addon_property_defaults:
		if not editor_settings.has_setting(prefix + n):
			var default = Consts.addon_property_defaults[n]
			var pname = prefix + n
			editor_settings.set(pname, default)
			editor_settings.set_initial_value(pname, default, false)

	for info in Consts.addon_property_infos:
		var new = info.duplicate()
		new.name = prefix + new.name
		editor_settings.add_property_info(new)

	for theme_p in Consts.theme_properties:
		var d_p = prefix + "day_theme/" + theme_p
		if not editor_settings.has_setting(d_p):
			editor_settings.set(d_p, editor_settings.get(theme_p))

		var n_p = prefix + "night_theme/" + theme_p
		if not editor_settings.has_setting(n_p):
			editor_settings.set(n_p, editor_settings.get(theme_p))

	for info in Consts.theme_properties_infos:
		var day_info = info.duplicate()
		day_info.name = prefix + "day_theme/" + day_info.name
		editor_settings.add_property_info(day_info)

		var night_info = info.duplicate()
		night_info.name = prefix + "night_theme/" + night_info.name
		editor_settings.add_property_info(night_info)

	self.disabled = false


# update sunrise/sunset time accourding to coordinates
func update_sun_times():
	self.disabled = true

	var longitude: float = editor_settings.get(prefix + "coordinates/longitude")
	var latitude: float = editor_settings.get(prefix + "coordinates/latitude")

	var time_zone = Time.get_time_zone_from_system()
	var h_bias = time_zone.bias / 60
	print("Time Zone [%s] applied." % time_zone.name)

	var sr = get_sunrise_hour()
	var new_sr = sun.calc_sun_time(longitude, latitude, sun.SUNRISE)
	if not is_equal_approx(sr, new_sr):
		var h = int(new_sr)
		var m = int((new_sr - h) * 60.0)
		h = h + h_bias
		h = h - 24 if h > 24 else h
		editor_settings.set(prefix + "sunrise_time/hour", h)
		editor_settings.set(prefix + "sunrise_time/minute", m)

	var ss = get_sunset_hour()
	var new_ss = sun.calc_sun_time(longitude, latitude, sun.SUNSET)
	if not is_equal_approx(ss, new_ss):
		var h = int(new_ss)
		var m = int((new_ss - h) * 60.0)
		h = h + h_bias
		h = h - 24 if h > 24 else h
		editor_settings.set(prefix + "sunset_time/hour", h)
		editor_settings.set(prefix + "sunset_time/minute", m)

	self.disabled = false


# save current theme as preset
func save_theme(theme_path: String):
	for theme_p in Consts.theme_properties:
		var d_p = prefix + theme_path + "/" + theme_p
		editor_settings.set(d_p, editor_settings.get(theme_p))


func apply_theme(theme_path: String):
	self.disabled = true

	var has_changed := false
	for theme_p in Consts.theme_properties:
		var d_p = prefix + theme_path + "/" + theme_p
		var old = editor_settings.get(theme_p)
		var new = editor_settings.get(d_p)
		if old == new or (old is float and is_equal_approx(old, new)):
			continue
		else:
			editor_settings.set(theme_p, editor_settings.get(d_p))
			has_changed = true

	self.disabled = false

	return has_changed
