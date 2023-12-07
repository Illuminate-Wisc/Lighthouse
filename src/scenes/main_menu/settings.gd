extends MarginContainer
class_name Settings

signal opened
signal closed

var main_theme := preload("res://src/ui/themes/main/main_theme.tres")
var user_text_bg := preload("res://src/ui/themes/main/panel/user_text_background_panel.tres")

@onready var font_size_slider := $PanelContainer/PaddedContainer/SettingsContainer/FontSizeSlider
@onready var dark_mode_button := $PanelContainer/PaddedContainer/SettingsContainer/GridContainer/DarkMode
@onready var light_mode_button := $PanelContainer/PaddedContainer/SettingsContainer/GridContainer/LightMode

func _ready():
	font_size_slider.value = main_theme.get_font_size("font_size", "UserTextFont")
	var is_dark_mode := main_theme.get_color("font_color","UserTextFont") == Color(1,1,1)
	dark_mode_button.disabled = is_dark_mode
	light_mode_button.disabled = not is_dark_mode
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if visible:
			visible = false
			closed.emit()
		else:
			visible = true
			opened.emit()

func _on_exit_button_pressed():
	SoundPlayer.play_sound("UISound")
	visible = false
	closed.emit()

func _on_font_size_slider_value_changed(value):
	main_theme.set_font_size("font_size", "UserTextFont", value)
	main_theme.set_font_size("font_size", "UserTextFontSmaller", value * 3 / 4)

func _on_light_mode_pressed():
	SoundPlayer.play_sound("UISound")
	main_theme.set_color("font_color", "UserTextFont", Color(0, 0, 0))  # Black font
	main_theme.set_color("font_color", "UserTextFontSmaller", Color(0, 0, 0))
	user_text_bg.bg_color = Color(1, 1, 1)  # White background
	dark_mode_button.disabled = false
	light_mode_button.disabled = true	

func _on_dark_mode_pressed():
	SoundPlayer.play_sound("UISound")
	main_theme.set_color("font_color", "UserTextFont", Color(1, 1, 1))  # White font
	main_theme.set_color("font_color", "UserTextFontSmaller", Color(1, 1, 1))
	user_text_bg.bg_color = Color(0.2, 0.2, 0.2)  # Dark gray background
	dark_mode_button.disabled = true
	light_mode_button.disabled = false	
