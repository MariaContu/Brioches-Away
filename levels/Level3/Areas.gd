extends Node2D

@onready var character = $"../YSort/Character"
@onready var areas = $"."
@onready var area_inicial = $area_inicial
@onready var levelpassedsound = $"../levelpassedsound"
@onready var bgsound = $"../bgsound"


var minigame_on = false

var shown_begin = false
const lines_begin: Array[String] = [
	"Quando a gente veio pra cá, eu não queria toma banho...",
	"Daí eu fiquei fugindo do banho por 10 minutos!"
]

var shown_patinho = false
const lines_patinho: Array[String] = [
	"Mamãe me fez tomar banho mesmo assim...",
	"Mas pelo menos fugi por uns minutinhos hehe."
]

var shown_mirror = false
const lines_mirror: Array[String] = [
	"Antigamente eu precisava de um banquinho...",
	"Agora eu sou grande!"
]

var shown_toilet = false
const lines_toilet: Array[String] = [
	"Quando papai usa o banheiro, fica fedido aqui..."
]

var shown_finishlevel = false
const lines_finishlevel: Array[String] = [
	"Agora me lembrei! Depois de tomar banho, eu e o Brioche fomos pro quintal.",
	"Estou chegando, Brioche!"
]

var gamewon = false

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

func interagir_patinho():
	if shown_patinho:
		if not gamewon:
			bgsound.stop()
			await start_minigame()
			gamewon = true
			
			#se ja ganhou o jogo, mensagens falando que devia ir para o quintal
			if not shown_finishlevel and not minigame_on:
				if not ChatManager.is_message_active:
					ChatManager.start_message(lines_finishlevel)
					await ChatManager.all_lines_displayed
					shown_finishlevel = true
					return
			return
	else:	
		if not ChatManager.is_message_active:
				ChatManager.start_message(lines_patinho)
				await ChatManager.all_lines_displayed
				shown_patinho = true
				return

func interagir_mirror():
	if shown_mirror:
		return
	if not ChatManager.is_message_active:
			ChatManager.start_message(lines_mirror)
			await ChatManager.all_lines_displayed
			shown_mirror = true

func interagir_toilet():
	if shown_toilet:
		return
	if not ChatManager.is_message_active:
			ChatManager.start_message(lines_toilet)
			await ChatManager.all_lines_displayed
			shown_toilet = true

func interagir_porta():
	if shown_finishlevel:
		bgsound.stop()
		levelpassedsound.play()
		
		TransitionLayer.transition("Level 4", "O Quintal")
		await TransitionLayer.transitionfinished
		#trocar de cena
		get_tree().change_scene_to_file("res://levels/Level4/level_4.tscn")
		return

func start_minigame():
	if minigame_on:
		return

	minigame_on = true
	var minigame_scene = preload("res://levels/Level3/minigame/dodgegame.tscn")
	var minigame_instance = minigame_scene.instantiate()
	
	character.set_physics_process(false)
	character.set_process(false)
	areas.set_physics_process(false)
	areas.set_process(false)
	
	get_tree().root.add_child(minigame_instance)
	await minigame_instance.gamewon
	get_tree().root.remove_child(minigame_instance)
	
	character.set_physics_process(true)
	character.set_process(true)
	areas.set_physics_process(true)
	areas.set_process(true)
	
	bgsound.play()
	minigame_on = false
