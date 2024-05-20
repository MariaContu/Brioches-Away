extends CharacterBody2D

var speed = 64.0

func _physics_process(delta):
	if Input.is_action_just_pressed("interaction"):
		_interact()
	_move()

func _move():
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left","move_right"),
		Input.get_axis("move_up","move_down")
	)
	
	velocity = _direction.normalized() * speed
	move_and_slide()

func _interact():
	print("interagiu!!! :)")
