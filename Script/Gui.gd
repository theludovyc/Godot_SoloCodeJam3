extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var life = 100.0

var invincible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Ennemy_hit(damage):
	if !invincible:
		$PlayerHit_ASP.play()
		
		$PlayerHit_Tween.interpolate_property($PlayerHit_Rect, "color", Color(1, 0, 0, 0.25), Color(1, 0, 0, 0), 0.2, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
		$PlayerHit_Tween.start()
		
		life -= damage;
		
		if life < 0:
			get_tree().reload_current_scene()

func doStart():
	$Timer.stop()
	
	$Center2/Label.visible = false
	
	$ASP_Music.play()

func _on_Timer_timeout():
	$Center2/Label.visible = !$Center2/Label.visible
	pass # Replace with function body.
