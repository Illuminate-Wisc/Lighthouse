extends MarginContainer
class_name Settings

signal exit_button_signal


var main_theme := preload("res://src/ui/themes/main/main_theme.tres")
var user_text_bg := preload("res://src/ui/themes/main/panel/user_text_background_panel.tres")

@onready var root_node := ($PanelContainer).owner
@onready var font_size_slider := $PanelContainer/PaddedContainer/SettingsContainer/FontSizeSlider
@onready var font_color_picker := $PanelContainer/PaddedContainer/SettingsContainer/GridContainer/FontColorPicker
@onready var background_color_picker := $PanelContainer/PaddedContainer/SettingsContainer/GridContainer/BackgroundColorPicker
@onready var font_size_readout := $PanelContainer/PaddedContainer/SettingsContainer/FontSizeReadout


func _ready():
    font_size_slider.value = main_theme.get_font_size("font_size", "UserTextFont")
    font_color_picker.color = main_theme.get_color("font_color", "UserTextFont")
    background_color_picker.color = user_text_bg.bg_color


func _process(_delta):
    if Input.is_action_just_pressed("ui_cancel"):
        root_node.visible = not root_node.visible


func _on_exit_button_pressed():
    exit_button_signal.emit()


func _on_font_size_slider_value_changed(value):
    main_theme.set_font_size("font_size", "UserTextFont", value)
    font_size_readout.text = str(value) + " px"


func _on_font_color_picker_color_changed(color):
    main_theme.set_color("font_color", "UserTextFont", color)


func _on_background_color_picker_color_changed(color):
    user_text_bg.bg_color = color
