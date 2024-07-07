extends Node2D

@onready var character = $"../Character"
@onready var camera_2d = $"../Character/Camera2D"
@onready var areas = $"."
@onready var area_inicial = $area_inicial
@onready var area_final = $area_final
@onready var levelpassedsound = $"../levelpassedsound"
@onready var bgsound = $"../bgsound"


var shown_begin = false
const lines_begin: Array[String] = [
	"Eita, parece que os arbustos cresceram...",
	"Tenho que chegar do outro lado, preciso ir até a entrada."
]

var saindo_level = false

func _ready():
	bgsound.play()


func interacao_inicial():
	if shown_begin:
		return
	if not ChatManager.is_message_active:
		ChatManager.start_message(lines_begin)
		await ChatManager.all_lines_displayed
		shown_begin = true
			
		if area_inicial:
			area_inicial.queue_free()
		return
			
func interacao_final():
	if not saindo_level:
		bgsound.stop()
		levelpassedsound.play()
		saindo_level = true
		
		TransitionLayer.transition("Level 5", "O Encontro")
		await TransitionLayer.transitionfinished
		get_tree().change_scene_to_file("res://levels/Level 5/level5.tscn")
				
		return
