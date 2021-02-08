tool
extends EditorPlugin

# template of addon property path in editor setting
const template := "interface/theme/auto_night_mode/%s"

# [properties, default_value] of addons
const properties = {
	"day_theme": {},
	"night_theme": {},

	"sunrise_time/hour": 0,
	"sunrise_time/minute": 0,

	"sunset_time/hour": 0,
	"sunset_time/minute": 0,

	"use_coordinates": false,
	"coordinates/latitude": .0,
	"coordinates/longitude": .0,

	"remove_properties_after_disabling": true,
}

# editor settings of what's a theme
const theme_properties = [
		"text_editor/theme/color_theme",
		"interface/theme/preset",
		"interface/theme/icon_and_font_color",
		"interface/theme/base_color",
		"interface/theme/accent_color",
		"interface/theme/contrast",
		"interface/theme/border_size",
		"interface/theme/use_graph_node_headers",
		"interface/theme/relationship_line_opacity",
		"interface/theme/highlight_tabs",
		"interface/theme/additional_spacing",
		"interface/theme/custom_theme",
]


var editor_settings := get_editor_interface().get_editor_settings()

# temporarily disable addon to prevent the signal-connected function calling itself
var disabling := false

# praise the sun ... algorithm
var sun := preload("sun.gd").new()

################################################################################
# getter & setter
################################################################################

func get_setting(n: String):
	return editor_settings.get(template % n)

func set_setting(n: String, v) -> void:
	editor_settings.set(template % n, v)

func has_setting(n: String) -> bool:
	return editor_settings.has_setting(template % n)

func erase_setting(n: String) -> void:
	editor_settings.erase(template % n)

func get_sunrise_time() -> float:
	return get_setting("sunrise_time/hour") + get_setting("sunrise_time/minute") / 60.0

func get_sunset_time() -> float:
	return get_setting("sunset_time/hour") + get_setting("sunset_time/minute") / 60.0


################################################################################
# virtual functions & signal function
################################################################################

func enable_plugin() -> void:
	init_missing_settings()


func disable_plugin() -> void:
	if get_setting("remove_properties_after_disabling"):
		for n in properties:
			erase_setting(n)


func _on_settings_changed() -> void:
	if disabling:
		return

	init_missing_settings()

	if get_setting("use_coordinates"):
		update_sun_times()

	update()


func _ready() -> void:
	update()
	editor_settings.connect("settings_changed", self, "_on_settings_changed")


var last_second: int = -1
func _process(delta: float) -> void:
	if disabling:
		return

	var t = OS.get_time()
	if t.second != last_second and t.second == 0:
		last_second = t.second
		update()


################################################################################
# actual functions
################################################################################

# init editor settings if haven't been added
func init_missing_settings() -> void:
	disabling = true

	for n in properties:
		if not has_setting(n):
			var v = properties[n]
			var full = template % n
			editor_settings.set(full, v)
			editor_settings.set_initial_value(full, v, false)
			editor_settings.add_property_info( { "name": full, "type": typeof(v) } )

	if not get_setting("day_theme").size():
		set_setting("day_theme", get_current_theme().duplicate(true))

	if not get_setting("night_theme").size():
		set_setting("night_theme", get_current_theme().duplicate(true))

	disabling = false


# update sunrise/sunset time accourding to coordinates
func update_sun_times():
	disabling = true

	var longitude: float = get_setting("coordinates/longitude")
	var latitude: float = get_setting("coordinates/latitude")

	var time_zone = OS.get_time_zone_info()
	var h_bias = time_zone.bias / 60
	print("Time Zone is %s" % time_zone.name)

	var sr = get_sunrise_time()
	var new_sr = sun.calc_sun_time(longitude, latitude, sun.SUNRISE)
	if not is_equal_approx(sr, new_sr):
		var h = int(new_sr)
		var m = int((new_sr - h) * 60.0)
		h = h + h_bias
		h = h - 24 if h > 24 else h
		set_setting("sunrise_time/hour", h)
		set_setting("sunrise_time/minute", m)

	var ss = get_sunset_time()
	var new_ss = sun.calc_sun_time(longitude, latitude, sun.SUNSET)
	if not is_equal_approx(ss, new_ss):
		var h = int(new_ss)
		var m = int((new_ss - h) * 60.0)
		h = h + h_bias
		h = h - 24 if h > 24 else h
		set_setting("sunset_time/hour", h)
		set_setting("sunset_time/minute", m)

	disabling = false


# update to day/night theme if current theme doesn't equal to corresponding theme
func update():
	var td = OS.get_time()
	var t: float = td.hour + td.minute / 60.0
	var sunrise := get_sunrise_time()
	var sunset := get_sunset_time()

	var rise: bool
	var sunrise_before_sunset := sunrise < sunset
	var time_gte_sunrise := (t >= sunrise and t < sunset)

	if sunrise_before_sunset:
		if time_gte_sunrise:
			rise = true
		else:
			rise = false
	else:
		if time_gte_sunrise:
			rise = false
		else:
			rise = true

	var cur_theme = get_current_theme()
	var day_theme = get_setting("day_theme")
	var night_theme = get_setting("night_theme")

	if rise:
		if not compare_dict(cur_theme, day_theme):
			print("Day theme applied.")
			apply_theme(day_theme)
	else:
		if not compare_dict(cur_theme, night_theme):
			print("Night theme applied.")
			apply_theme(night_theme)


func get_current_theme():
	var theme = {}
	for property in theme_properties:
		theme[property] = editor_settings.get(property)
	return theme


func apply_theme(theme: Dictionary):
	for k in theme:
		var v = theme[k]
		editor_settings.set(k, v)


func compare_dict(d1: Dictionary, d2: Dictionary):
	for k in d1:
		if d1[k] is float:
			if not is_equal_approx(d1[k], d2[k]):
#				print("key: %s" % k)
#				print("%s ! is_equal_approx %s" % [d1[k], d2[k]])
				return false
		elif d1[k] != d2[k]:
#			print("key: %s" % k)
#			print("%s != %s" % [d1[k], d2[k]])
			return false
	return true
