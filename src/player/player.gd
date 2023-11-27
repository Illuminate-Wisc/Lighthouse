extends Node3D
class_name Player

@export var pitch_amount: float = 0.25
@export var pitch_duration: float = 0.5
@export var default_pitch: float = 0.0

@export var desc_opacity_duration: float = 0.075

@export var rotation_speed: float = 1
@export var rotation_min_vel: float = 0.1
@export var rotation_damping: float = 0.8

@onready var raycast: RayCast3D = $Camera3D/RayCast
@onready var settings_menu := $CanvasLayer/Settings
@onready var desc_label := $CanvasLayer/Hud/Desc/DescContainer/DescLabel
@onready var desc_container := $CanvasLayer/Hud/Desc

var rotation_vel = 0
var pitch_tween: Tween
var desc_opacity_tween: Tween


func set_pitch(pitch: float):
    rotation.x = pitch


func set_desc_opacity(opacity: float):
    desc_container.modulate.a = opacity


func tween_desc_opacity(
        to_opacity: float,
        duration: float = desc_opacity_duration
    ):
    if desc_opacity_tween:
        desc_opacity_tween.stop()

    desc_opacity_tween = create_tween()

    desc_opacity_tween.tween_method(
            set_desc_opacity,
            desc_container.modulate.a,
            to_opacity,
            duration
        )


func tween_pitch(to_pitch: float, duration: float = pitch_duration):
    if pitch_tween:
        pitch_tween.stop()

    pitch_tween = create_tween()

    pitch_tween.tween_method(
            set_pitch,
            rotation.x,
            default_pitch + to_pitch,
            duration
        )


func _process(delta):
    if abs(rotation_vel) > rotation_min_vel:
        rotate_y(delta * rotation_vel)

        rotation_vel *= rotation_damping


    if settings_menu.visible:
        return


    
    if Input.is_action_pressed("look_left"):
        rotation_vel = rotation_speed

    if Input.is_action_pressed("look_right"):
        rotation_vel = -rotation_speed


    if Input.is_action_pressed("look_down"):
        tween_pitch(-pitch_amount)

    elif Input.is_action_pressed("look_up"):
        tween_pitch(pitch_amount)

    elif rotation.x != default_pitch:
        tween_pitch(0)


func _on_ray_cast_changed_target(new_target: FocusObserver):
    if new_target == null:
        tween_desc_opacity(0)
        return

    if "description" not in new_target.get_parent():
        return

    var description: String = new_target.get_parent().description

    if description != "":
        tween_desc_opacity(1)
        desc_label.text = description


func _on_settings_exit_button_signal():
    settings_menu.visible = false

