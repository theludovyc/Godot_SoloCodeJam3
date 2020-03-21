extends StaticBody

var deathSound = preload("res://Art/Sarg/Sound/dssgtdth.wav")

var life:float = 30

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = translation.direction_to(get_parent().get_player().translation)
	
	rotation.y = atan2(dir.x, dir.z)
	pass

func death():
	$CollisionShape.disabled = true
	
	$ASP3.stream = deathSound
	$ASP3.play()
	
	$AnimatedSprite3D.play("death")
	
	print("death")

func doHit(damage:float):
	#print("I do hit !")
	$Tween.interpolate_property($AnimatedSprite3D, "modulate", Color(1, 0.5, 0.5, 1), Color(1, 1, 1, 1), 0.3, Tween.TRANS_QUART, Tween.EASE_IN)
	$Tween.start()
	$ASP3.play()
	
	life -= damage
	
	if life < 0:
		death()
