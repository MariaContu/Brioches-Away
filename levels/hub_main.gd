extends Node

@onready var bgsound = $bgsound
@onready var buttonsound = $buttonsound


func _ready():
	bgsound.play()

func _on_startbutton_pressed():
	bgsound.stop()
	buttonsound.play()
	
	TransitionLayer.transition("Level 0:", "O Quarto de Agatha")
	await TransitionLayer.transitionfinished

	get_tree().change_scene_to_file("res://levels/Level0/level_0.tscn")
