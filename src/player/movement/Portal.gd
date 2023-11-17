extends Node3D

@export var to_scene: String
@export var outline_size_focused: float = 0.8
@export var outline_size_unfocused: float = 0.3
@export var outline_transition_duration: float = 0.2

@export var r_unfocused: float = 0.5
@export var r_focused: float = 0.8

@onready var outline_mat = $Pillar.get_active_material(0)
@onready var color = outline_mat.albedo_color

var outline_size: float = outline_size_unfocused
var radius: float = r_unfocused

func set_radius(r: float):
	radius = r
	$Pillar.mesh.set_bottom_radius(radius)
	$Pillar.mesh.set_top_radius(radius)

func _ready():
	outline_mat.albedo_color = Color(color.r, color.g, color.b, outline_size_unfocused)
	$Pillar.set_surface_override_material(0, outline_mat)
	set_radius(r_unfocused)


func set_outline_size(size: float):
	outline_size = size
	outline_mat.albedo_color = Color(color.r, color.g, color.b, outline_size)
	$Pillar.set_surface_override_material(0, outline_mat)


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
		
	create_tween().tween_method(
			set_radius,
			radius,
			r_focused,
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
		
	create_tween().tween_method(
			set_radius,
			radius,
			r_unfocused,
			duration
		)


func _on_focus_observer_selected():
	SceneSwitcher.to(to_scene)
