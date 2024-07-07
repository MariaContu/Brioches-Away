extends Node2D

@onready var character = $Character
@onready var bgsound = $bgsound
@onready var areas = $Areas


func _ready():
	character.speed = 120
	bgsound.play()

func _process(delta):
	verificar_interacao()

func verificar_interacao():
	var overlapping = false
	
	for area in areas.get_children():
		if area is Area2D and area.get_overlapping_bodies().has(character):
			overlapping = true
			if area.name == 'area_inicial':
				interacao_inicial()
				return
			elif area.name == 'area_final':
				interacao_final()
				return
			

	if not overlapping:
		if ChatManager.is_message_active:
				ChatManager.stop_message()

				
func interacao_inicial():
	areas.interacao_inicial()
	pass
	
func interacao_final():
	areas.interacao_final()
	pass
