extends CharacterBody2D

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

var speed = 64.0
var _state_machine

func _ready():
	_state_machine = _animation_tree["parameters/playback"]
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("interaction"):
		_interact()
	_move()
	_animate()

func _move():
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left","move_right"),
		Input.get_axis("move_up","move_down")
	)
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
	
	velocity = _direction.normalized() * speed
	move_and_slide()

func _animate():
	if velocity.length()>2:
		_state_machine.travel("walk")
		return
	_state_machine.travel("idle")

func _interact():
	print("interagiu!!! :)")
