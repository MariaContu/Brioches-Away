extends Node

@onready var chat_box_scene = preload("res://dialogues/chatbox.tscn")
var message_lines : Array[String] = []
var current_line = 0

var chat_box

var is_message_active = false
var can_advance_message = false

signal all_lines_displayed

func start_message(lines: Array[String]):
	if is_message_active:
		return
		
	message_lines = lines
	show_text()
	is_message_active = true
	
func show_text():
	chat_box = chat_box_scene.instantiate()
	chat_box.text_display_finished.connect(_all_text_displayed)
	get_tree().root.add_child(chat_box)
	chat_box.display_text(message_lines[current_line])
	can_advance_message = false
	
func _all_text_displayed():
	can_advance_message = true
	
func _unhandled_input(event):
	if(event.is_action_pressed("interact") and is_message_active and can_advance_message):
		chat_box.queue_free()
		current_line += 1
		if current_line >= message_lines.size():
			is_message_active = false
			current_line = 0
			emit_signal("all_lines_displayed")
		else:
			show_text()

func stop_message():
	if is_message_active:
		chat_box.queue_free()
		is_message_active = false
		current_line = 0

