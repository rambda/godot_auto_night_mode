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
		"type": TYPE_REAL,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "-90, 90",
	},
	{
		"name": "coordinates/longitude",
		"type": TYPE_REAL,
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
	"interface/theme/border_size",
	"interface/theme/use_graph_node_headers",
	"interface/theme/relationship_line_opacity",
	"interface/theme/highlight_tabs",
	"interface/theme/additional_spacing",
	"interface/theme/custom_theme",

	"text_editor/theme/color_theme",
	"text_editor/theme/line_spacing",

	"text_editor/highlighting/symbol_color",
	"text_editor/highlighting/keyword_color",
	"text_editor/highlighting/control_flow_keyword_color",
	"text_editor/highlighting/base_type_color",
	"text_editor/highlighting/engine_type_color",
	"text_editor/highlighting/user_type_color",
	"text_editor/highlighting/comment_color",
	"text_editor/highlighting/string_color",
	"text_editor/highlighting/background_color",
	"text_editor/highlighting/completion_background_color",
	"text_editor/highlighting/completion_selected_color",
	"text_editor/highlighting/completion_existing_color",
	"text_editor/highlighting/completion_scroll_color",
	"text_editor/highlighting/completion_font_color",
	"text_editor/highlighting/text_color",
	"text_editor/highlighting/line_number_color",
	"text_editor/highlighting/safe_line_number_color",
	"text_editor/highlighting/caret_color",
	"text_editor/highlighting/caret_background_color",
	"text_editor/highlighting/text_selected_color",
	"text_editor/highlighting/selection_color",
	"text_editor/highlighting/brace_mismatch_color",
	"text_editor/highlighting/current_line_color",
	"text_editor/highlighting/line_length_guideline_color",
	"text_editor/highlighting/word_highlighted_color",
	"text_editor/highlighting/number_color",
	"text_editor/highlighting/function_color",
	"text_editor/highlighting/member_variable_color",
	"text_editor/highlighting/mark_color",
	"text_editor/highlighting/bookmark_color",
	"text_editor/highlighting/breakpoint_color",
	"text_editor/highlighting/executing_line_color",
	"text_editor/highlighting/code_folding_color",
	"text_editor/highlighting/search_result_color",
	"text_editor/highlighting/search_result_border_color"
]


const theme_properties_infos = [
	{
		"name": "interface/theme/preset",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "Default,Alien,Arc,Godot 2,Grey,Light,Solarized (Dark),Solarized (Light),Custom",
	},
	{
		"name": "interface/theme/icon_and_font_color",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "Auto,Dark,Light",
	},
	{
		"name": "interface/theme/contrast",
		"type": TYPE_REAL,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "-1, 1, 0.01",
	},
	{
		"name": "interface/theme/relationship_line_opacity",
		"type": TYPE_REAL,
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
		"name": "interface/theme/additional_spacing",
		"type": TYPE_REAL,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0,5,0.1",
	},
	{
		"name": "interface/theme/custom_theme",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_GLOBAL_FILE,
		"hint_string": "*.res,*.tres,*.theme",
	},
	{
		"name": "text_editor/theme/color_theme",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM_SUGGESTION,
		"hint_string": "Adaptive,Default,Custom",
	},
	{
		"name": "text_editor/theme/line_spacing",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "0,50,1",
	},
]
