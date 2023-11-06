extends Node3D


@onready var init_y := position.y

var theta = 0


func _process(delta):
    theta += delta

    position.y = init_y + sin(5 * theta) * 0.1
    rotation.z = sin(3 * theta) * 0.1

    if theta > TAU:
        theta = theta - TAU
