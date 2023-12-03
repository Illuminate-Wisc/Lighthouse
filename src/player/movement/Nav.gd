extends Node3D

@export var to_scene: String
@export var description: String
@export var normal_opacity: float = 0.05
@export var focused_opacity: float = 0.5
@export var opacity_duration: float = 0.25
@export var sound: String

@onready var orb_mat: StandardMaterial3D = $Orb.get_active_material(0)
@onready var arrow := $Arrow
@onready var init_arrow_pos: Vector3 = arrow.position

var opacity_tween: Tween
var theta := 0.0 # For arrow animation


func _ready():
    orb_mat.albedo_color.a = normal_opacity


func _process(delta):
    theta += PI * delta

    if theta >= TAU:
        theta -= TAU

    arrow.position.z = init_arrow_pos.z + sin(theta) / 40


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
    tween_opacity(focused_opacity)


func _on_focus_observer_unfocused():
    tween_opacity(normal_opacity)


func _on_focus_observer_selected():
    SceneSwitcher.to(to_scene)
