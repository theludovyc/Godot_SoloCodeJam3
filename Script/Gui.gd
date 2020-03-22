extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Ennemy_hit(damage):
	$PlayerHit_ASP.play()
	
	$PlayerHit_Tween.interpolate_property($PlayerHit_Rect, "color", Color(1, 0, 0, 0.25), Color(1, 0, 0, 0), 0.2, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$PlayerHit_Tween.start()
	
	pass # Replace with function body.
