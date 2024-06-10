extends Node2D

@onready var personagem = $YSort/Character
@onready var areas = $Areas

func _ready():
	pass

func _process(delta):
	verificar_interacao()

func verificar_interacao():
	var overlapping = false
	
	for area in areas.get_children():
		if area is Area2D and area.get_overlapping_bodies().has(personagem):
			overlapping = true
			if area.name == 'area_inicial':
				interacao_inicial()
				return
			if area.name == 'area_cozinha':
				interagir_com_cozinha()
				return
			if Input.is_action_just_pressed("interact"):
				match area.name:
					"area_puzzle":
						interagir_com_puzzle()
					"area_books":
						interagir_com_livros()
					"area_clock":
						interagir_com_relogio()
						
	if not overlapping:
		if ChatManager.is_message_active:
				ChatManager.stop_message()

func interagir_com_cozinha():
	areas.interagir_com_cozinha()
	
func interagir_com_puzzle():
	areas.interagir_com_puzzle()
	
func interagir_com_relogio():
	areas.interagir_com_clock()
	
func interagir_com_livros():
	areas.interagir_com_books()

func interacao_inicial():
	print("Interação Inicial realizada!")
	areas.interacao_inicial()
