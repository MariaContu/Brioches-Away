extends Node2D

@onready var personagem = $YSort/Character
@onready var areas = $Areas
@onready var fotos_geladeira = $Areas/geladeira/fotos_geladeira
@onready var secret = $Secret

func _ready():
	fotos_geladeira.hide()


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
					"area_puzzle":
						interagir_com_puzzle()
					"geladeira":
						interagir_com_geladeira()
					"area_final":
						interacao_final()
						
	if not overlapping:
		if ChatManager.is_message_active:
				ChatManager.stop_message()
		fotos_geladeira.hide()
		secret.hide()

func interagir_com_puzzle():
	areas.interagir_com_puzzle()
	
func interagir_com_geladeira():
	areas.interagir_com_geladeira()

func interacao_inicial():
	print("Interação Inicial realizada!")
	areas.interacao_inicial()

func interacao_final():
	areas.interacao_final()
