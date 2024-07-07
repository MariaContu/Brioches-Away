extends CanvasLayer

@onready var text_label = $"label_margin/text_label"
@onready var letter_timer = $"letter_timer"

var text = ""
var letter_index = 0

var letter_display_timer := 0.04
var space_display_timer := 0.05
var ponctuation_display_timer := 0.03

signal text_display_finished()

func display_text(text_to_display: String):
	text = text_to_display
	text_label.text = text_to_display
	
	text_label.text = ""
	display_letter()
	
func display_letter():
	if letter_index >= text.length():
		text_display_finished.emit()
		return
	
	text_label.text += text[letter_index]
	letter_index+=1
	
	if letter_index < text.length():
		match text[letter_index]:
			"!","?",",",".":
				letter_timer.start(ponctuation_display_timer)
			" ":
				letter_timer.start(space_display_timer)
			_:
				letter_timer.start(letter_display_timer)

func _on_letter_timer_timeout():
	display_letter()
