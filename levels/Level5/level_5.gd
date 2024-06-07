extends Node2D

@onready var character = $Character
@onready var bgsound = $bgsound

func _ready():
	character.speed = 120
	bgsound.play()
