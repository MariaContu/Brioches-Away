extends Node2D

@export var drop_scene : PackedScene

signal gamewon
var score

@onready var player = $player
@onready var drop_timer = $drop_timer
@onready var score_timer = $score_timer
@onready var start_timer = $start_timer
@onready var start_position = $start_position
@onready var hud_minigame = $hud_minigame
@onready var gamearea = $bg

#audios references
@onready var bgsound = $bgsound
@onready var gameoversound = $gameoversound
@onready var winsound = $winsound

func _ready():
	bgsound.play()

func game_over():
	if score >= 10:
		drop_timer.stop()
		score_timer.stop()
		#sounds
		bgsound.stop()
		winsound.play()
		hud_minigame.show_message("Você Venceu!")
		await  get_tree().create_timer(2.0).timeout
		#emit signal game won
		gamewon.emit()
		return
		
	drop_timer.stop()
	score_timer.stop()
	hud_minigame.show_gameover()
	#sounds
	bgsound.stop()
	gameoversound.play()
	await gameoversound.finished
	await  get_tree().create_timer(1.0).timeout
	bgsound.play()

func new_game():
	start_timer.start()
	player.start_pos(start_position.position)
	score = 0
	
	hud_minigame.update_score(score)
	hud_minigame.show_message("Se prepare!")
	get_tree().call_group("drops","queue_free")

func _on_score_timer_timeout():
	score += 1
	hud_minigame.update_score(score)

func _on_start_timer_timeout():
	drop_timer.start()
	score_timer.start()

func _on_drop_timer_timeout():
	if score > 10:
		#vamos alterar o wait time para aumentar a dificuldade
		if score > 15:
			drop_timer.wait_time = 0.2
		
		else:
			drop_timer.wait_time = 0.4
	
	var drop = drop_scene.instantiate()
	var drop_location = $drops_path/droppathlocation
	drop_location.progress_ratio = randf()
	
	var direction = drop_location.rotation + PI/2
	drop.position = drop_location.position
	direction += randf_range(-PI/4, PI/4)
	drop.rotation = direction

	var velocity = Vector2(randf_range(160.0, 130.0),0.0)
	drop.linear_velocity = velocity.rotated(direction)

	#criar os limites do bg
	var rect_globalpos = gamearea.global_position
	var rect_size = gamearea.size
	
	var min_x = rect_globalpos.x
	var max_x = rect_globalpos.x + rect_size.x
	var min_y = rect_globalpos.y
	var max_y = rect_globalpos.y + rect_size.y
	
	#ajusta a posicao para ficar dentro do quadrado do jogo
	drop.position.x = clamp(drop.position.x, min_x, max_x)
	drop.position.y = clamp(drop.position.y, min_y, max_y)
	
	drop.set_game_limit(min_x,max_x,min_y,max_y)
	
	add_child(drop)
