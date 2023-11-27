extends Node3D
@export var show_info: String
@onready var init_y := position.y

var move: bool = false
var theta: float = 0


func _ready():
	pass

func _physics_process(delta):
	if move:
		theta += PI / 2 * delta
		position.y = init_y + sin(theta) / 8


func _on_focus_observer_focused():
	move = true


func _on_focus_observer_unfocused():
	move = false


func _on_focus_observer_selected():
	var object = get_node(show_info) as UITextBox
	object.visible = true
	object.start()
