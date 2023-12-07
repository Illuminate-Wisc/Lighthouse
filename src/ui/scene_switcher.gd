extends CanvasLayer

@export var load_animation_duration: float = 1.0

@onready var dissolve_player: AnimationPlayer = $AnimationPlayer
@onready var loading_player: AnimationPlayer = $LoadingAnimationPlayer

@onready var loading_label: Label = $DissolveRect/MarginContainer/VBoxContainer/Label
@onready var label_length = len(loading_label.text)


var tween


func to(scene: String) -> void:
	dissolve_player.play("dissolve")
	loading_player.play("loading")

	await dissolve_player.animation_finished

	get_tree().change_scene_to_file(scene)

	dissolve_player.play_backwards("dissolve")

	await dissolve_player.animation_finished

	loading_player.stop()
