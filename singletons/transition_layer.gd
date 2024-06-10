extends CanvasLayer

signal transitionfinished

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer
@onready var levelname = $levelname
@onready var leveldesc = $leveldesc

func _ready():
	color_rect.visible = false
	
func transition(name, desc):
	levelname.text = name
	leveldesc.text = desc
	
	color_rect.visible = true
	animation_player.play("fade_in")


func _on_animation_finished(anim_name):
	if anim_name == "fade_in":
		await  get_tree().create_timer(1.5).timeout #para dar tempo de ler o level
		transitionfinished.emit()
		animation_player.play("fade_out")
	elif anim_name == "fade_out":
		color_rect.visible = false
