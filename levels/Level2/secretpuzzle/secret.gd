extends CanvasLayer

@onready var purpletext = $Control/purpletext
@onready var bluetext = $Control/bluetext
@onready var greentext = $Control/greentext
@onready var button_pressed = $button_pressed

var purpleInt = 0
var blueInt = 0
var greenInt = 0
var password = 135

signal secret_solved

func _ready():
	pass

func check_password():
	if greenInt == 1 and blueInt == 3 and purpleInt == 5:
		emit_signal("secret_solved")

func _on_purpleplus_pressed():
	if purpleInt == 9:
		purpleInt = 0
	else:
		purpleInt += 1
	button_pressed.play()
	purpletext.text = str(purpleInt)
	check_password()

func _on_purpleminus_pressed():
	if purpleInt == 0:
		purpleInt = 9
	else:
		purpleInt -= 1
	button_pressed.play()
	purpletext.text = str(purpleInt)
	check_password()

func _on_blueplus_pressed():
	if blueInt == 9:
		blueInt = 0
	else:
		blueInt += 1
	button_pressed.play()
	bluetext.text = str(blueInt)
	check_password()

func _on_blueminus_pressed():
	if blueInt == 0:
		blueInt = 9
	else:
		blueInt -= 1
	button_pressed.play()
	bluetext.text = str(blueInt)
	check_password()

func _on_greenplus_pressed():
	if greenInt == 9:
		greenInt = 0
	else:
		greenInt += 1
	button_pressed.play()
	greentext.text = str(greenInt)
	check_password()

func _on_greenminus_pressed():
	if greenInt == 0:
		greenInt = 9
	else:
		greenInt -= 1
	button_pressed.play()
	greentext.text = str(greenInt)
	check_password()

func _on_hide_pressed():
	hide()
