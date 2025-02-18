extends Node

@export var start_dialogue : Array[String]

var _text : DialogueText
var _dialogue_sequences : Array

func _ready() -> void:
	_text = get_tree().get_first_node_in_group("DialogueText")
	_text.dialogue_finished.connect(dialogue_finished)
	
	add_sequence(start_dialogue)

func add_sequence(sequence: Array[String]):
	_dialogue_sequences.append_array(sequence)

func dialogue_finished():
	_play_next_dialogue()

func _play_next_dialogue() -> void:
	if _dialogue_sequences.is_empty():
		print("Finished!")
		return
	
	_text.set_next_text(_dialogue_sequences.pop_front())
