extends Node

@onready var audio_player_door = $AudioStreamDoor as AudioStreamPlayer
@onready var audio_player_ding = $AudioStreamDing as AudioStreamPlayer
@onready var audio_player_stairs = $AudioStreamStairs as AudioStreamPlayer



var sounds = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	sounds = {
		"DingSound": audio_player_ding,
		"DoorSound": audio_player_door,
		"StairStepSound": audio_player_stairs
	}

func play_sound(sound: String):
	sounds[sound].play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
