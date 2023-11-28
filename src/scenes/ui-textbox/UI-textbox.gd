extends CanvasLayer

class_name UITextBox


const CHAR_READ_RATE = 0.05 # Time it takes for each character to appear

@onready var textbox_container: Control = $TextboxContainer
@onready var start_symbol: Label = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol: Label = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var rich_label: RichTextLabel = $TextboxContainer/MarginContainer/HBoxContainer/Label
var tween: Tween

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []



func _ready():
	pass
	
func start():
	hide_textbox()
	queue_text("Lighthouse inspectors also brought traveling libraries to the keepers and their families.")
	queue_text("These libraries consisted of 50 books on topics including religion, poetry, history, and novels.")
	queue_text("The libraries were delivered twice a year and were highly sought after by the keepers.")
	queue_text("Lighthouse keepers would keep lists of what books they desired.")

func _process(delta: float) -> void:
	match current_state:
		State.READY:
			if not text_queue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				print("reading")
				tween.stop()
				# Skip to the end of the current text immediately
				skip_to_end_of_text()
				
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()

func queue_text(next_text: String) -> void:
	text_queue.push_back(next_text)

func hide_textbox() -> void:
	start_symbol.text = ""
	end_symbol.text = ""
	rich_label.text = ""
	textbox_container.visible = false

func show_textbox() -> void:
	start_symbol.text = "*"
	textbox_container.visible = true

func display_text() -> void:
	var next_text = text_queue.pop_front()
	rich_label.text = next_text
	rich_label.visible_characters = 0
	change_state(State.READING)
	show_textbox()
	var total_characters = next_text.length()
	var total_time = total_characters * CHAR_READ_RATE
	tween = create_tween()
	tween.tween_property(rich_label, "visible_characters", total_characters, total_time)
	tween.connect("finished", _on_tween_tween_completed)

	
func skip_to_end_of_text() -> void:
	rich_label.visible_characters = rich_label.text.length()
	change_state(State.FINISHED)
	end_symbol.text = "v"

func change_state(next_state: State) -> void:
	current_state = next_state

# Connect this in the editor or via code if you need to handle when the tween completes
func _on_tween_tween_completed() -> void:
	if current_state == State.READING:
		end_symbol.text = "v"
		change_state(State.FINISHED)
