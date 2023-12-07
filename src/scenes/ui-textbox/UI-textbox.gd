extends CanvasLayer


signal finished

const CHAR_READ_RATE = 0.025 # Time it takes for each character to appear

@onready var margin_container: Control = $MarginContainer
@onready var start_symbol: Label = $MarginContainer/ScrollContainer/PanelContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol: Label = $MarginContainer/ScrollContainer/PanelContainer/MarginContainer/HBoxContainer/End
@onready var label := $MarginContainer/ScrollContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Label
@onready var main_theme: Theme = preload("res://src/ui/themes/main/main_theme.tres")

var enabled = true


	
enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []
var tween: Tween


func enable():
	enabled = true


func disable():
	enabled = false


func start(poi_name: String):
	hide_textbox()

	var info_lines = PointOfInterestData.get_info(poi_name)

	if info_lines.is_empty():
		finished.emit()
		return

	for line in info_lines:
		queue_text(line)


func _process(_delta: float) -> void:
	if not enabled:
		return

	match current_state:
		State.READY:
			if not text_queue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				SoundPlayer.play_sound("UISound")
				tween.stop()
				# Skip to the end of the current text immediately
				skip_to_end_of_text()
				
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				SoundPlayer.play_sound("UISound")
				change_state(State.READY)
				label.text = ""
				end_symbol.text = ""

				if text_queue.is_empty():
					margin_container.visible = false
					finished.emit()


func queue_text(next_text: String) -> void:
	text_queue.push_back(next_text)


func hide_textbox() -> void:
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	margin_container.visible = false


func show_textbox() -> void:
	start_symbol.text = "*"
	margin_container.visible = true


func display_text() -> void:
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.visible_characters = 0
	change_state(State.READING)
	show_textbox()
	var total_characters = next_text.length()
	var total_time = total_characters * CHAR_READ_RATE
	tween = create_tween()
	tween.tween_property(label, "visible_characters", total_characters, total_time)
	tween.connect("finished", _on_tween_tween_completed)


func skip_to_end_of_text() -> void:
	label.visible_characters = label.text.length()
	change_state(State.FINISHED)
	end_symbol.text = "v"


func change_state(next_state: State) -> void:
	current_state = next_state


# Connect this in the editor or via code if you need to handle when the tween completes
func _on_tween_tween_completed() -> void:
	if current_state == State.READING:
		end_symbol.text = "v"
		change_state(State.FINISHED)
