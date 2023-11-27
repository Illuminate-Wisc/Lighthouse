extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func to(scene: String) -> void:
    animation_player.play("dissolve")
    await $AnimationPlayer.animation_finished

    get_tree().change_scene_to_file(scene)

    animation_player.play_backwards("dissolve")
