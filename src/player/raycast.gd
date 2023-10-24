extends RayCast3D

signal changed_target(new_target: FocusObserver)

var cur_target: FocusObserver


func _process(_delta):
    var new_target = get_collider()

    if new_target != cur_target: # Looking at a new target
        changed_target.emit(new_target)

        if cur_target != null:
            cur_target.unfocus()

        if new_target is FocusObserver:
            cur_target = new_target
            cur_target.focus()
        else:
            cur_target = null

    if cur_target != null and Input.is_action_just_pressed("select"):
            cur_target.select()
