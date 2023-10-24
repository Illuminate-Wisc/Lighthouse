extends Node3D

@export var to_scene: String
@export var outline_size_focused: float = 0.1
@export var outline_size_unfocused: float = 0.0
@export var outline_transition_duration: float = 0.2

@onready var outline_mat = $Door.get_active_material(0).next_pass

var outline_size: float = 0.0


func _ready():
    outline_mat.set_shader_parameter("outline_size", 0.0)


func set_outline_size(size: float):
    outline_size = size
    outline_mat.set_shader_parameter("outline_size", outline_size)


func get_focus_progress() -> float:
    return (outline_size - outline_size_unfocused) / outline_size_focused


func get_focus_transition_duration() -> float:
    var progress = get_focus_progress()

    return (1 - progress) * outline_transition_duration


func get_unfocus_transition_duration() -> float:
    var progress = get_focus_progress()

    return progress * outline_transition_duration


func _on_focus_observer_focused():
    var duration = get_focus_transition_duration()

    create_tween().tween_method(
            set_outline_size,
            outline_size,
            outline_size_focused,
            duration
        )


func _on_focus_observer_unfocused():
    var duration = get_unfocus_transition_duration()

    create_tween().tween_method(
            set_outline_size,
            outline_size,
            outline_size_unfocused,
            duration
        )


func _on_focus_observer_selected():
    SceneSwitcher.to(to_scene)
