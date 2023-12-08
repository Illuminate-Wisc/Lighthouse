extends Node3D

@export var move_amount := 0.2
@export var move_rate := 5
@export var rotate_amount := 0.1
@export var rotate_rate := 3

@onready var init_y := position.y

var theta = 0


func _process(delta):
    theta += delta

    position.y = init_y + sin(move_rate * theta) * move_amount
    rotation.z = sin(rotate_rate * theta) * rotate_amount

    if theta > TAU:
        theta = theta - TAU
