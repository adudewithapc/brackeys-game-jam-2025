extends RichTextLabel
class_name DialogueText

signal dialogue_finished

@onready var _type_timer := $TypeTimer

var _target_text : String
var _current_char_index := 0

func _ready() -> void:
	set_next_text("So I can write a bunch of things here and hopefully it will look very nice dude")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next"):
		_finish_typing()

func set_next_text(next_text: String):
	_target_text = next_text
	text = ""
	_current_char_index = -1
	_type_timer.start()

func _finish_typing() -> void:
	_type_timer.stop()
	text = _target_text
	dialogue_finished.emit()

func _on_type_timer_timeout() -> void:
	if text.length() == _target_text.length():
		_type_timer.stop()
		return
	
	_type_next_letter()

func _is_text_finished() -> bool:
	return text.length() == _target_text.length()

func _type_next_letter() -> void:
	_current_char_index += 1
	var current_char := _target_text[_current_char_index]
	text += current_char
	
	if current_char == ' ':
		_type_next_letter()
