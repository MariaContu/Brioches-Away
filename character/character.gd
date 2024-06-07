extends CharacterBody2D

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

@onready var footstepssound = $footstepssound



var speed = 64.0
var _state_machine

func _ready():
	_state_machine = _animation_tree["parameters/playback"]
	pass

func _physics_process(delta):
	_move()
	_animate()
	_play_footsteps()

func _move():
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
	
	velocity = _direction.normalized() * speed
	move_and_slide()

func _animate():
	if velocity.length() > 2:
		_state_machine.travel("walk")
		return
	_state_machine.travel("idle")

func _play_footsteps():
	if velocity.length() > 2:
		if not footstepssound.playing:
			footstepssound.play()
	else:
		if footstepssound.playing:
			footstepssound.stop()
