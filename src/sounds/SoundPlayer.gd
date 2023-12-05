extends Node

@onready var audio_player_door = $AudioStreamDoor as AudioStreamPlayer
@onready var audio_player_ding = $AudioStreamDing as AudioStreamPlayer
@onready var audio_player_stairs = $AudioStreamStairs as AudioStreamPlayer

var ding = preload("res://src/sounds/ding-36029.mp3")
var doorSound = preload("res://src/sounds/squeaky-door-open-113212.mp3")
var stairSound = preload("res://src/sounds/metal-stairs-foot-steps-29688.mp3")


var sounds = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	#audio_player.stream = ding
	#audio_player.play()
	audio_player_door.stream = doorSound
	audio_player_ding.stream = ding
	audio_player_stairs.stream = stairSound
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
