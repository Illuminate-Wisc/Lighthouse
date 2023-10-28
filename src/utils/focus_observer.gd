extends Area3D
class_name FocusObserver


signal focused
signal unfocused
signal selected


func focus() -> void:
    focused.emit()


func unfocus() -> void:
    unfocused.emit()


func select() -> void:
    selected.emit()
