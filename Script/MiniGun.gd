extends Control

signal shoot

var miniGun0 = preload("res://Art/MiniGun/chgga0.png")
var miniGun1 = preload("res://Art/MiniGun/chggb0.png")

var firing = false;

var state = false;

func reset():
	$MG.texture = miniGun0
	$Fire.visible = false
	state = false

func nextState():
	if state:
		$MG.texture = miniGun0
		$Fire.visible = true
		$ASP.play()
	else:
		$MG.texture = miniGun1
		$Fire.visible = false
		$ASP.play()
		
	emit_signal("shoot")
	
	state = !state

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !firing and Input.is_action_just_pressed("mouseLeft"):
		$Timer.start()
		firing=true
		
	if firing and Input.is_action_just_released("mouseLeft"):
		$Timer.stop()
		reset()
		firing=false
	pass


func _on_Timer_timeout():
	nextState()
	pass # Replace with function body.
