extends Node3D

signal selected(poi_name: String)

@export var normal_opacity: float = 0.05
@export var focused_opacity: float = 0.5
@export var opacity_duration: float = 0.25
@export var description: String
@export var poi_name: String

@onready var init_rot: float = rotation.y
@onready var orb_mat: StandardMaterial3D = $Orb.get_active_material(0)

var theta: float = 0
var opacity_tween: Tween


func _ready():
	orb_mat.albedo_color.a = normal_opacity


func _process(delta):
	rotation.y = init_rot + sin(theta) / 2
	theta += PI / 2 * delta


func set_opacity(opacity: float):
	orb_mat.albedo_color.a = opacity


func tween_opacity(to_opacity: float, duration: float = opacity_duration):
	if opacity_tween:
		opacity_tween.stop()

	opacity_tween = create_tween()

	opacity_tween.tween_method(
			set_opacity,
			orb_mat.albedo_color.a,
			to_opacity,
			duration
		)


func _on_focus_observer_focused():
	# TODO: play sound
	tween_opacity(focused_opacity)


func _on_focus_observer_unfocused():
	tween_opacity(normal_opacity)


func _on_focus_observer_selected():
	# TODO?: play sound
	selected.emit(poi_name)
