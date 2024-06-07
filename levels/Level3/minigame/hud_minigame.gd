extends CanvasLayer

@onready var message_label = $Control/message_label
@onready var message_timer = $message_timer
@onready var scorelabel = $Control/scorelabel
@onready var start_button = $Control/startButton
@onready var info_button = $Control/infoButton
@onready var info_label = $Control/info_label

#sounds
@onready var buttonsound = $buttonsound

signal start_game

func _ready():
	info_label.hide()

func show_message(text):
	message_label.text = text
	message_label.show()
	message_timer.start()
	
func show_gameover():
	show_message("Game Over")
	await message_timer.timeout
	
	message_label.text = "Fuja do Banho"
	message_label.show()
	start_button.show()
	info_button.show()
	
func update_score(score):
	scorelabel.text = str(score)

func _on_start_button_pressed():
	buttonsound.play()
	start_button.hide()
	info_button.hide()
	start_game.emit()

func _on_message_timer_timeout():
	message_label.hide()

func _on_info_button_pressed():
	if info_button.text == "<":
		buttonsound.play()
		info_label.hide()
		start_button.show()
		scorelabel.show()
		info_button.text = "?"
		message_label.show()
	
	else:
		info_button.text = "<"
		buttonsound.play()
		start_button.hide()
		scorelabel.hide()
		message_label.hide()
		info_label.show()
	
	
