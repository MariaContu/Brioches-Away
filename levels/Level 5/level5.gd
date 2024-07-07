extends Node2D

@onready var personagem = $YSort/Character
@onready var brioche = $brioche
@onready var area_inicial = $area_inicial
@onready var levelpassedsound = $levelpassedsound
@onready var bgsound = $bgsound


var messages_init = false
const lines_init: Array[String] = [
	"Brioche!"
]

var messages_end = false
const lines_end: Array[String] = [
	"Nunca mais vou te perder Brioche."
]

func _ready():
	bgsound.play()

func _process(delta):
	verificar_interacao()

func verificar_interacao():
	var overlapping = false
	
	if brioche.get_overlapping_bodies().has(personagem):
		overlapping = true
		
		personagem._state_machine.travel("idle")
		personagem.footstepssound.stop()
		personagem.set_physics_process(false)
		personagem.set_process(false)
		
		if not messages_end:
			if not ChatManager.is_message_active:
				ChatManager.start_message(lines_end)
				await ChatManager.all_lines_displayed
				messages_end = true
				levelpassedsound.play()
				
				TransitionLayer.transition("","")
				await TransitionLayer.transitionfinished
				get_tree().change_scene_to_file("res://levels/creditos.tscn")
				
				return
				
	if area_inicial.get_overlapping_bodies().has(personagem):
		overlapping = true
		if not messages_init:
			if not ChatManager.is_message_active:
				ChatManager.start_message(lines_init)
				await ChatManager.all_lines_displayed
				messages_init = true
				return
	
	if not overlapping:
		if ChatManager.is_message_active:
				ChatManager.stop_message()
