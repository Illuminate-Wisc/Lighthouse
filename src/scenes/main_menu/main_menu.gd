extends Node3D


@export var start_scene = "res://src/scenes/world/world.tscn"

@onready var main_buttons_container = $CanvasLayer/MainButtonsContainer
@onready var settings = $CanvasLayer/Settings


func _on_settings_pressed():
	SoundPlayer.play_sound("UISound")
	main_buttons_container.visible = false
	settings.visible = true


func _on_settings_opened():
	SoundPlayer.play_sound("UISound")
	main_buttons_container.visible = false


func _on_settings_closed():
	SoundPlayer.play_sound("UISound")
	main_buttons_container.visible = true


func _on_start_pressed():
	SoundPlayer.play_sound("UISound")
	SceneSwitcher.to(start_scene)


func _on_quit_pressed():
	get_tree().quit()

