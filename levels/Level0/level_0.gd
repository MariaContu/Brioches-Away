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
			if Input.is_action_just_pressed("interact"):
				match area.name:
					"area_paper":
						interagir_com_papel()
					"area_bookshelf":
						interagir_com_estante()
					"area_clock":
						interagir_com_relogio()
					"area_door":
						interagir_com_porta()
	if not overlapping:
		areas.drawing.hide()
		if ChatManager.is_message_active:
				ChatManager.stop_message()

func interagir_com_papel():
	print("Interagindo com o papel.")
	areas.interagir_com_papel()

func interagir_com_estante():
	print("Interagindo com a estante.")
	areas.interagir_com_estante()

func interagir_com_relogio():
	print("Interagindo com o relógio.")
	areas.interagir_com_relogio()

func interagir_com_porta():
	print("Interagindo com a porta.")
	areas.interagir_com_porta()

func interacao_inicial():
	print("Interação Inicial realizada!")
	areas.interacao_inicial()
