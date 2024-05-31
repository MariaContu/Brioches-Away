extends Node2D

@onready var area_paper = $area_paper
@onready var personagem = $"../YSort/Character"
@onready var drawing = $drawing
@onready var area_bookshelf = $area_bookshelf
@onready var area_clock = $area_clock
@onready var area_plant = $area_plant
@onready var area_door = $area_door

var key_found = false

var messages_shown_bookshelf = false
const lines_bookshelf: Array[String] = [
	"Foi o papai que botou esses livros aqui.",
	"Prefiro meus desenhos!"
]

var messages_shown_bookshelf_with_key = false
const lines_bookshelf_key: Array[String] = [
	"Hmm, parece que tem uma coisa aqui embaixo da estante...",
	"Ahá! Uma chave. Vou ficar com ela."
]

var messages_shown_paper = false
const lines_paper: Array[String] = [
	"Um papel no meio do quarto...",
	"Se a mamãe ver, vai ficar braba...",
	"Olha só! Acho que é um desenho antigo meu."
]

var messages_shown_clock = false
const lines_clock: Array[String] = [
	"Hmm... As coisinhas não se mexem."
]

var messages_shown_plant = false
const lines_plant: Array[String] = [
	"Uuuu que planta linda!"
]

var messages_shown_door_before = false
const lines_door_before: Array[String] = [
	"Ue... Tá trancada. Deve ter algo por aqui pra ajudar..."
]

var messages_shown_door_after = false
const lines_door_after: Array[String] = [
	"Vamos ver se a chave funciona...",
	"Abriu!",
	"Vamos achar o brioche!"
	]

func _ready():
	drawing.hide()

func interagir_com_papel():
	if messages_shown_paper:
		if drawing.visible:
			drawing.hide()
		else:
			drawing.show()
	else:
		if not ChatManager.is_message_active:
			ChatManager.start_message(lines_paper)
			await ChatManager.all_lines_displayed
			messages_shown_paper = true

func interagir_com_estante():
	if key_found:
		return

	if messages_shown_paper:
		if not ChatManager.is_message_active:
			ChatManager.start_message(lines_bookshelf_key)
			await ChatManager.all_lines_displayed
			key_found = true
	else:
		if messages_shown_bookshelf:
			return
			
		if not ChatManager.is_message_active:
			ChatManager.start_message(lines_bookshelf)
			await ChatManager.all_lines_displayed
			messages_shown_bookshelf = true

func interagir_com_relogio():
	if messages_shown_clock:
		return
	if not ChatManager.is_message_active:
		ChatManager.start_message(lines_clock)
		await ChatManager.all_lines_displayed
		messages_shown_clock = true

func interagir_com_planta():
	if messages_shown_plant:
		return
	if not ChatManager.is_message_active:
		ChatManager.start_message(lines_plant)
		await ChatManager.all_lines_displayed
		messages_shown_plant = true

func interagir_com_porta():
	if messages_shown_door_after:
		return
		
	if key_found:
		if not ChatManager.is_message_active:
			ChatManager.start_message(lines_door_after)
			await ChatManager.all_lines_displayed
			messages_shown_door_after = true
			print("fim do level 0")

	if messages_shown_door_before:
		return
	if not ChatManager.is_message_active:
		ChatManager.start_message(lines_door_before)
		await ChatManager.all_lines_displayed
		messages_shown_door_before = true
