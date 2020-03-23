extends Tween


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ht:float

var b = false

func do():
	if b:
		interpolate_property($"../AnimatedSprite3D", "translation:y", ht, ht-0.2, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		b = false
	else:
		interpolate_property($"../AnimatedSprite3D", "translation:y", ht-0.2, ht, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		b = true
	
	start()

# Called when the node enters the scene tree for the first time.
func _ready():
	ht = $"../AnimatedSprite3D".translation.y
	
	do()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_T_Move_tween_all_completed():
	do()
	pass # Replace with function body.
