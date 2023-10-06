extends Object


# [properties, default_value]
const addon_property_defaults = {
	"erase_settings_after_disabling": true,

	"coordinates/use_coordinates": false,
	"coordinates/latitude": .0,
	"coordinates/longitude": .0,

	"sunrise_time/hour": 0,
	"sunrise_time/minute": 0,

	"sunset_time/hour": 0,
	"sunset_time/minute": 0,
}


const addon_property_infos = [
	{
		"name": "coordinates/latitude",
		"type": TYPE_FLOAT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "-90, 90",
	},
	{
		"name": "coordinates/longitude",
		"type": TYPE_FLOAT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "-180, 180",
	},
	{
		"name": "sunrise_time/hour",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0, 23, 1",
	},
	{
		"name": "sunrise_time/minute",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0, 60, 1",
	},
	{
		"name": "sunset_time/hour",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0, 23, 1",
	},
	{
		"name": "sunset_time/minute",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0, 60, 1",
	},
]


const theme_properties = [
	"interface/theme/preset",
	"interface/theme/icon_and_font_color",
	"interface/theme/base_color",
	"interface/theme/accent_color",
	"interface/theme/contrast",
	"interface/theme/draw_extra_borders",
	"interface/theme/icon_saturation",
	"interface/theme/relationship_line_opacity",
	"interface/theme/border_size",
	"interface/theme/corner_radius",
	"interface/theme/additional_spacing",
	"interface/theme/custom_theme",
	
	"text_editor/theme/highlighting/symbol_color",
	"text_editor/theme/highlighting/keyword_color",
	"text_editor/theme/highlighting/control_flow_keyword_color",
	"text_editor/theme/highlighting/base_type_color",
	"text_editor/theme/highlighting/engine_type_color",
	"text_editor/theme/highlighting/user_type_color",
	"text_editor/theme/highlighting/comment_color",
	"text_editor/theme/highlighting/string_color",
	"text_editor/theme/highlighting/background_color",
	"text_editor/theme/highlighting/completion_background_color",
	"text_editor/theme/highlighting/completion_selected_color",
	"text_editor/theme/highlighting/completion_existing_color",
	"text_editor/theme/highlighting/completion_font_color",
	"text_editor/theme/highlighting/text_color",
	"text_editor/theme/highlighting/line_number_color",
	"text_editor/theme/highlighting/safe_line_number_color",
	"text_editor/theme/highlighting/caret_color",
	"text_editor/theme/highlighting/selection_color",
	"text_editor/theme/highlighting/brace_mismatch_color",
	"text_editor/theme/highlighting/current_line_color",
	"text_editor/theme/highlighting/line_length_guideline_color",
	"text_editor/theme/highlighting/word_highlighted_color",
	"text_editor/theme/highlighting/number_color",
	"text_editor/theme/highlighting/function_color",
	"text_editor/theme/highlighting/member_variable_color",
	"text_editor/theme/highlighting/mark_color",
	"text_editor/theme/highlighting/breakpoint_color",
	"text_editor/theme/highlighting/code_folding_color",
	"text_editor/theme/highlighting/search_result_color"
]


const theme_properties_infos = [
	{
		"name": "interface/theme/preset",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "Default,Breeze Dark,Godot 2,Gray,Light,Solarized (Dark),Solarized (Light),Black (OLED),Custom",
	},
	{
		"name": "interface/theme/icon_and_font_color",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "Auto,Dark,Light",
	},
	{
		"name": "interface/theme/contrast",
		"type": TYPE_FLOAT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "-1, 1, 0.01",
	},
	{
		"name": "interface/theme/draw_extra_borders",
		"type": TYPE_BOOL
	},
	{
		"name": "interface/theme/icon_saturation",
		"type": TYPE_FLOAT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0.00, 2, 0.01",
	},
	{
		"name": "interface/theme/relationship_line_opacity",
		"type": TYPE_FLOAT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0.00, 1, 0.01",
	},
	{
		"name": "interface/theme/border_size",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0,2,1",
	},
	{
		"name": "interface/theme/corner_radius",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0,6,1",
	},
	{
		"name": "interface/theme/additional_spacing",
		"type": TYPE_FLOAT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0,5,0.1",
	},
	{
		"name": "interface/theme/custom_theme",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_GLOBAL_FILE,
		"hint_string": "*.res,*.tres,*.theme",
	},
]
