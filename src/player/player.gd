extends Node3D
class_name Player

@export var rotation_speed: float = 1
@export var pitch_amount: float = 0.25
@export var pitch_duration: float = 0.5
@export var rotation_min_vel = 0.1
@export var rotation_damping = 0.8
@export var default_pitch = 0.0

@onready var raycast: RayCast3D = $Camera3D/RayCast

var rotation_vel = 0
var pitch_tween: Tween



func set_pitch(pitch: float):
	rotation.x = pitch


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
	if Input.is_action_pressed("look_left"):
		rotation_vel = rotation_speed

	if Input.is_action_pressed("look_right"):
		rotation_vel = -rotation_speed

	if abs(rotation_vel) > rotation_min_vel:
		rotate_y(delta * rotation_vel)

		rotation_vel *= rotation_damping


	if Input.is_action_pressed("look_down"):
		tween_pitch(-pitch_amount)

	elif Input.is_action_pressed("look_up"):
		tween_pitch(pitch_amount)

	elif rotation.x != default_pitch:
		tween_pitch(0)


func _on_ray_cast_changed_target(new_target: FocusObserver):
	if new_target == null:
		return

	if new_target.get_parent().name == "Gateway":
		# TODO: display destination name as text
		pass

