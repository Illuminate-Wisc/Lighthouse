extends MarginContainer
class_name Settings

signal opened
signal closed

var main_theme := preload("res://src/ui/themes/main/main_theme.tres")
var user_text_bg := preload("res://src/ui/themes/main/panel/user_text_background_panel.tres")

@onready var font_size_slider := $PanelContainer/PaddedContainer/SettingsContainer/FontSizeSlider
@onready var font_size_readout := $PanelContainer/PaddedContainer/SettingsContainer/FontSizeReadout
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
	visible = false
	closed.emit()

func _on_font_size_slider_value_changed(value):
	main_theme.set_font_size("font_size", "UserTextFont", value)
	font_size_readout.text = str(value) + " px"

func _on_dark_mode_option_button_item_selected(index):
	if index == 0:  # Dark mode
		main_theme.set_color("font_color", "UserTextFont", Color(1, 1, 1))  # White font
		user_text_bg.bg_color = Color(0.2, 0.2, 0.2)  # Dark gray background
	else:  # Light mode
		main_theme.set_color("font_color", "UserTextFont", Color(0, 0, 0))  # Black font
		user_text_bg.bg_color = Color(1, 1, 1)  # White background


func _on_light_mode_pressed():
	main_theme.set_color("font_color", "UserTextFont", Color(0, 0, 0))  # Black font
	user_text_bg.bg_color = Color(1, 1, 1)  # White background
	dark_mode_button.disabled = false
	light_mode_button.disabled = true	


func _on_dark_mode_pressed():
	main_theme.set_color("font_color", "UserTextFont", Color(1, 1, 1))  # White font
	user_text_bg.bg_color = Color(0.2, 0.2, 0.2)  # Dark gray background
	dark_mode_button.disabled = true
	light_mode_button.disabled = false	
