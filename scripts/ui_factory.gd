class_name UIFactory
extends RefCounted

static func panel_style(color: Color, radius: int = 28, border_color: Color = Color.TRANSPARENT, border: int = 0) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.corner_radius_top_left = radius
	box.corner_radius_top_right = radius
	box.corner_radius_bottom_left = radius
	box.corner_radius_bottom_right = radius
	box.border_width_left = border
	box.border_width_top = border
	box.border_width_right = border
	box.border_width_bottom = border
	box.border_color = border_color
	box.shadow_color = Color(0.01, 0.05, 0.20, 0.35)
	box.shadow_size = 12
	return box

static func make_button(text_value: String, color: Color = Color("ef3340"), size := Vector2(600, 132)) -> Button:
	var button := Button.new()
	button.text = text_value
	button.custom_minimum_size = size
	button.add_theme_font_size_override("font_size", 46)
	button.add_theme_color_override("font_color", Color.WHITE)
	button.add_theme_color_override("font_hover_color", Color.WHITE)
	button.add_theme_stylebox_override("normal", panel_style(color, 50, Color(1, 1, 1, 0.55), 5))
	button.add_theme_stylebox_override("hover", panel_style(color.lightened(0.10), 50, Color.WHITE, 5))
	button.add_theme_stylebox_override("pressed", panel_style(color.darkened(0.12), 50, Color.WHITE, 5))
	button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
	return button

static func make_label(text_value: String, font_size: int, color := Color.WHITE) -> Label:
	var label := Label.new()
	label.text = text_value
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", color)
	label.add_theme_color_override("font_shadow_color", Color(0.01, 0.04, 0.18, 0.8))
	label.add_theme_constant_override("shadow_offset_x", 4)
	label.add_theme_constant_override("shadow_offset_y", 5)
	return label

static func fill_parent(control: Control) -> void:
	control.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

