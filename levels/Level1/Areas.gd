extends Node2D

@onready var levelpassedsound = $"../levelpassedsound"
@onready var bgsound = $"../bgsound"
@onready var area_inicial = $area_inicial

var puzzle_solved = false
var saindolevel = false

var messages_shown_books = false
const lines_books: Array[String] = [
	"Esses livros tem um monte de palavra dificil..."
]

var messages_shown_clock = false
const lines_clock: Array[String] = [
	"Aqui funciona as pontinhas. Mas eu não sei o que significam..."
]

var messages_on_begin = false
const lines_begin: Array[String] = [
	"Quando a gente veio pra cá, acho que a gente ficou brincando um pouco..."
]

var messages_kitchen_before = false
const lines_kitbefore: Array[String] = [
	"Ainda não lembro direito o que eu e o Brioche fizemos depois...",
	"Acho melhor descobrir antes de sair daqui..."
]

var messages_puzzle = false
const lines_puzzle: Array[String] = [
	"Acho que a gente tava brincando aqui aquela hora..."
]



func _ready():
	bgsound.play()

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

func interagir_com_cozinha():
	if puzzle_solved:
		if not saindolevel:
			bgsound.stop()
			levelpassedsound.play()
			
			saindolevel = true
			
			TransitionLayer.transition("Level 2", "A Cozinha")
			await TransitionLayer.transitionfinished
			
			get_tree().change_scene_to_file("res://levels/Level2/level2.tscn")
			return
			
	if messages_kitchen_before:
		return
	if not ChatManager.is_message_active:
		ChatManager.start_message(lines_kitbefore)
		await ChatManager.all_lines_displayed
		messages_kitchen_before = true
		
		

func interagir_com_puzzle():
	if messages_puzzle:
		return
	if not ChatManager.is_message_active:
			ChatManager.start_message(lines_puzzle)
			await ChatManager.all_lines_displayed
			messages_puzzle = true
			puzzle_solved = true
	
func interagir_com_books():
	if messages_shown_books:
		return
	if not ChatManager.is_message_active:
			ChatManager.start_message(lines_books)
			await ChatManager.all_lines_displayed
			messages_shown_books = true

func interagir_com_clock():
	if messages_shown_clock:
		return
	if not ChatManager.is_message_active:
			ChatManager.start_message(lines_clock)
			await ChatManager.all_lines_displayed
			messages_shown_clock = true
