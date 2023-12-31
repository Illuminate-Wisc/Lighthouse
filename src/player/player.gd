extends Node3D
class_name Player

@export var pitch_amount: float = 0.25
@export var pitch_duration: float = 0.5
@export var default_pitch: float = 0.0

@export var desc_opacity_duration: float = 0.075
@export var desc_max_opacity: float = 0.98

@export var rotation_acc: float = 0.1
@export var rotation_min_vel: float = 0.1
@export var rotation_damping: float = 0.9

@onready var enabled := true
@onready var raycast: RayCast3D = $Camera3D/RayCast
@onready var settings_menu := $SettingsLayer/Settings
@onready var desc_label := $HUDLayer/Hud/Desc/DescContainer/DescLabel
@onready var desc_container := $HUDLayer/Hud/Desc
@onready var controls := $HUDLayer/Hud/Controls
@onready var textbox := $TextboxLayer

var rotation_vel = 0
var pitch_tween: Tween
var desc_opacity_tween: Tween
var sound_list = ["DoorSound", "StairStepSound"]

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


	if not enabled:
		return


	if Input.is_action_pressed("look_left"):
		rotation_vel += rotation_acc

	if Input.is_action_pressed("look_right"):
		rotation_vel -= rotation_acc


	if Input.is_action_pressed("look_down"):
		tween_pitch(-pitch_amount)

	elif Input.is_action_pressed("look_up"):
		tween_pitch(pitch_amount)

	elif rotation.x != default_pitch:
		tween_pitch(0)


func _on_ray_cast_changed_target(new_target: FocusObserver):
	"""
	# stop all sounds
	for sound in sound_list:
		if has_node(sound):
			var sound_obj = get_node(sound) as AudioStreamPlayer
			sound_obj.stop() 
	"""
	
			
	if new_target == null:
		tween_desc_opacity(0)
		return


	if "description" in new_target.get_parent():
		var description: String = new_target.get_parent().description
		if description != "":
			tween_desc_opacity(desc_max_opacity)
			desc_label.text = description

	
	"""
	# play the selected sound
	if "sound" in new_target.get_parent():
		var sound: String = new_target.get_parent().sound

		if sound != "" and has_node(sound):
			var sound_obj = get_node(sound) as AudioStreamPlayer
			sound_obj.play() 
	"""
	SoundPlayer.play_sound("DingSound")



func _on_point_of_interest_selected(poi_name: String):
	if not enabled:
		return


	textbox.visible = true
	controls.visible = false
	enabled = false

	textbox.start(poi_name)


func _on_settings_opened():
	enabled = false

	if textbox.visible:
		textbox.disable()


func _on_settings_closed():
	if textbox.visible:
		textbox.enable()
	else:
		enabled = true


func _on_textbox_layer_finished():
	textbox.visible = false
	controls.visible = true
	enabled = true
