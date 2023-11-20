extends Control


@export var start_scene = "res://src/scenes/world/world.tscn"

@onready var main_buttons = $MainButtons as Control
@onready var settings = $Settings as Settings


# Called when the node enters the scene tree for the first time.
func _ready():
	settings.exit_button_signal.connect(_on_return_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if Input.is_action_just_pressed("ui_cancel"):
        if main_buttons_container.visible == false:
            main_buttons_container.visible = true
        else:
            main_buttons_container.visible = false


# go to the settings menu
func _on_settings_pressed():
    main_buttons_container.visible = false
    settings.visible = true


func _on_return_button_pressed():
    main_buttons_container.visible = true
    settings.visible = false


func _on_start_pressed():
    SceneSwitcher.to(start_scene)


func _on_quit_pressed():
    get_tree().quit()

