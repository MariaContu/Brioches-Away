extends Area2D

@onready var collision = $collision

signal hit

var speed = 100
var minigame_size = Vector2(192, 144)
var minigame_position = Vector2()

func _ready():
	minigame_position.x = (320 - minigame_size.x) / 2
	minigame_position.y = (192 - minigame_size.y) / 2
	
	hide()

func _process(delta):
	var velocity = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if velocity.length()>0:
		velocity = velocity.normalized() * speed
		
	position+=velocity * delta
	
	position.x = clamp(position.x, minigame_position.x, minigame_position.x + minigame_size.x)
	position.y = clamp(position.y, minigame_position.y, minigame_position.y + minigame_size.y)


func _on_body_entered(body):
	hide()
	hit.emit()
	collision.set_deferred("disabled", true)

func start_pos(pos):
	position = pos
	show()
	collision.disabled = false
