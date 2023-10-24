extends Node3D
class_name Player

@export var rotation_speed: float = PI / 5

@onready var raycast: RayCast3D = $Camera3D/RayCast


func _physics_process(delta):
    if Input.is_action_pressed("look_left"):
        rotate_y(delta * rotation_speed)

    if Input.is_action_pressed("look_right"):
        rotate_y(-delta * rotation_speed)


func _on_ray_cast_changed_target(new_target: FocusObserver):
    if new_target == null:
        return

    if new_target.get_parent().name == "Gateway":
        # TODO: display destination name as text
        pass

