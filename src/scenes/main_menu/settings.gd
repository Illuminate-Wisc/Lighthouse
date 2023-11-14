class_name Settings
extends Control
#@export var text_color : Color
signal exit_button_signal

# Assuming your Label node is named 'Label' and is a direct child of the HBoxContainer
@onready var sizeTextLabel = $SettingTabs/Text/MarginContainer/TextSetting/SizeContainer/TextSize
@onready var colorTextLabel = $SettingTabs/Text/MarginContainer/TextSetting/ColorContainer/TextColor
@onready var textSetting = $SettingTabs/Text/MarginContainer/TextSetting
@onready var slider = $SettingTabs/Text/MarginContainer/TextSetting/SizeContainer/TextSizeSlider

func _on_exit_button_pressed():
	exit_button_signal.emit()

func _on_color_picker_button_color_changed(color: Color):
	for child in textSetting.get_children():
		if child is Control:
			child.set_modulate(color)

func _on_text_size_slider_value_changed(value):
	for child in textSetting.get_children():
		# Check if the child is a Control node and has a theme font size property
		if child is Control and child.has_theme_font_size_override("font_size"):
			# Remove the existing font size override
			child.remove_theme_font_size_override("font_size")
			sizeTextLabel.remove_theme_font_size_override("font_size")
			colorTextLabel.remove_theme_font_size_override("font_size")
		# Apply the new font size override
		child.add_theme_font_size_override("font_size", int(value))
		sizeTextLabel.add_theme_font_size_override("font_size", int(value))
		colorTextLabel.add_theme_font_size_override("font_size", int(value))


