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
					"area_bath":
						interagir_bath()
					"area_mirror":
						interagir_mirror()
					"area_toilet":
						interagir_toilet()
					"area_door":
						interagir_porta()
	if not overlapping:
		if ChatManager.is_message_active:
				ChatManager.stop_message()

func interacao_inicial():
	print("Interação Inicial realizada!")
	areas.interacao_inicial()

func interagir_bath():
	areas.interagir_patinho()
	
func interagir_mirror():
	areas.interagir_mirror()

func interagir_toilet():
	areas.interagir_toilet()

func interagir_porta():
	areas.interagir_porta()
