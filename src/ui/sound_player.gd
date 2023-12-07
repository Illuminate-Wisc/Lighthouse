extends Node

@onready var audio_player_door = $AudioStreamDoor as AudioStreamPlayer
@onready var audio_player_ding = $AudioStreamDing as AudioStreamPlayer
@onready var audio_player_stairs = $AudioStreamStairs as AudioStreamPlayer


var sounds = {}


func _ready():
	sounds = {
		"DingSound": audio_player_ding,
		"DoorSound": audio_player_door,
		"StairStepSound": audio_player_stairs
	}


func play_sound(sound: String):
	if sound == "DingSound":
		sounds[sound].pitch_scale = 1 + randf() * 0.25
	else:
		sounds[sound].pitch_scale = 1 + randf() * 0.95

	sounds[sound].play()
