extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sarg = preload("res://Scene/Sarg.tscn")
var skull = preload("res://Scene/Skull.tscn")

var portal_pos:PoolVector3Array

var start = false

func get_player():
	return $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	portal_pos.append($PortalXmZm.translation)
	portal_pos.append($PortalXpZm.translation)
	portal_pos.append($PortalXpZp.translation)
	portal_pos.append($PortalXmZp.translation)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !start:
		if Input.is_action_just_pressed("mouseLeft"):
			$Gui.doStart()

			$Timer.start()

			start = true
			pass
	
	pass

func _on_Timer_timeout():
	var m
	
	if randf() > 0.6:
		m = skull.instance()
	else:
		m = sarg.instance()
		m.connect("hit", $Gui, "_on_Ennemy_hit")
	
	m.translation = portal_pos[randi()%portal_pos.size()]
	
	add_child(m)
	pass # Replace with function body.
