extends Node

@onready var audio_player_door = $AudioStreamDoor as AudioStreamPlayer
@onready var audio_player_ding = $AudioStreamDing as AudioStreamPlayer
@onready var audio_player_stairs = $AudioStreamStairs as AudioStreamPlayer
@onready var audio_player_UI = $AudioStreamUI as AudioStreamPlayer
@onready var audio_player_BG = $AudioStreamBG as AudioStreamPlayer


var sounds = {}


func _ready():
	sounds = {
		"DingSound": audio_player_ding,
		"DoorSound": audio_player_door,
		"StairStepSound": audio_player_stairs,
		"UISound": audio_player_UI,
		"BGSound": audio_player_BG,
	}
	audio_player_BG.play()
	


func play_sound(sound: String):
	if sound == "DingSound":
		sounds[sound].pitch_scale = 1 + randf() * 0.1
	elif sound == "UISound":
		sounds[sound].pitch_scale = .95 + randf() * 0.05
	else:
		sounds[sound].pitch_scale = 1.4 + randf() * 0.2

	sounds[sound].play()
	
func set_volume_bg(volume: float):
	if volume <= -60:
		audio_player_BG.set_stream_paused(true)
	else:
		audio_player_BG.set_stream_paused(false)
	audio_player_BG.volume_db = volume
		
func get_volume_bg():
	return audio_player_BG.volume_db
