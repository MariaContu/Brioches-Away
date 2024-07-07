extends Node2D

@onready var solved = $"../solved"
@onready var levelpassedsound = $"../levelpassedsound"
@onready var bgsound = $"../bgsound"
@onready var area_inicial = $area_inicial
@onready var secret = $"../Secret"
@onready var fotos_geladeira = $geladeira/fotos_geladeira

var puzzle_solved = false
var saindolevel = false

var messages_on_begin = false
const lines_begin: Array[String] = [
	"Hmm, ainda ta com o cheiro daquele bolinho que a mamãe tinha feito.",
	"Mas não lembro a receita... Vamos procurar!"
]

var messages_before_puzzle = false
const lines_puz_bef: Array[String] = [
	"Ah, a mamãe guarda aqui as receitas dela!",
	"Mas ta trancado... Devo descobrir algo para me ajudar a abrir."
]

var messages_box_open = false
const lines_box: Array[String] = [
	"Lembrei! Depois de comer o bolinho, a mamãe me disse para ir tomar banho."
]

var messages_bef_solved = false
const lines_door_bef: Array[String] = [
	"Ainda não posso sair... Não achei a receitinha da mamãe."
]

var messages_aft_solved = false
const lines_door_aft: Array[String] = [
	"Estou chegando Brioche!"
]

func _ready():
	secret.hide()
	bgsound.play()
	secret.connect("secret_solved",Callable(self,"on_secret_solved"))

func interacao_inicial():
	if messages_on_begin:
		return
	if not ChatManager.is_message_active:
			ChatManager.start_message(lines_begin)
			await ChatManager.all_lines_displayed
			messages_on_begin = true
			
			if area_inicial:
				area_inicial.queue_free()
			return

func interacao_final():
	if puzzle_solved:
		if messages_aft_solved:
			bgsound.stop()
			levelpassedsound.play()
			
			TransitionLayer.transition("Level 3", "O Banheiro")
			
			await TransitionLayer.transitionfinished
			get_tree().change_scene_to_file("res://levels/Level3/level3.tscn")
			
			return
			
		if not ChatManager.is_message_active:
			ChatManager.start_message(lines_door_aft)
			await ChatManager.all_lines_displayed
			messages_aft_solved = true
			return
	else:
		if not messages_bef_solved:
			if not ChatManager.is_message_active:
				ChatManager.start_message(lines_door_bef)
				await ChatManager.all_lines_displayed
				messages_bef_solved = true
				return

func interagir_com_puzzle():
	if messages_before_puzzle:			
		if not puzzle_solved:
			secret.show()
		return
	if not ChatManager.is_message_active:
		ChatManager.start_message(lines_puz_bef)
		await ChatManager.all_lines_displayed
		messages_before_puzzle = true

func interagir_com_geladeira():
	if fotos_geladeira.visible:
		fotos_geladeira.hide()
		return
	else:
		fotos_geladeira.show()

func on_secret_solved():
	puzzle_solved=true
	solved.play()
	await solved.finished
	secret.hide()
	if not ChatManager.is_message_active:
		ChatManager.start_message(lines_box)
		await ChatManager.all_lines_displayed
		messages_box_open = true
		return
