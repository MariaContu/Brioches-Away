extends RigidBody2D

var min_x
var max_x
var min_y
var max_y

func set_game_limit(min_x, max_x, min_y, max_y):
	self.min_x = min_x
	self.max_x = max_x
	self.min_y = min_y
	self.max_y = max_y

func _process(delta):
	if position.x < min_x or position.x > max_x or position.y < min_y or position.y > max_y:
		queue_free()
