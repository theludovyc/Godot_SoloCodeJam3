extends StaticBody

signal hit(damage)

const SPEED = 2.0

var atkSound = preload("res://Art/Sarg/Sound/dssgtsit.wav")
var hitSound = preload("res://Art/Sarg/Sound/dsdmpain.wav")
var deathSound = preload("res://Art/Sarg/Sound/dssgtdth.wav")

var life:float = 30

var follow = true

var attack = true

const DAMAGE = 10

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
#func _ready():
#	$AnimatedSprite3D.play("move")
#	pass # Replace with function body.

func doAtk():
	$AnimatedSprite3D.frame = 0
	$AnimatedSprite3D.play("attack")
	
	$ASP3.stream = atkSound
	$ASP3.play()
	
	emit_signal("hit", DAMAGE)
	
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var p_t = get_parent().get_player().translation
	
	var dir = translation.direction_to(p_t)
	
	rotation.y = atan2(dir.x, dir.z)
	
	if follow:
		if translation.distance_to(p_t) > 1.35:
			if attack:
				attack = false
			
			if $Timer.is_stopped():
				translation += Vector3(dir.x, 0, dir.z) * delta * SPEED
		elif !attack:
			doAtk()
			attack = true

func death():
	attack = false
	
	$Timer.stop()
	
	$CollisionShape.disabled = true
	
	$ASP3.stream = deathSound
	$ASP3.play()
	
	$AnimatedSprite3D.play("death")
	
	follow = false
	print("death")

func doHit(damage:float):
	#print("I do hit !")
	$Tween.interpolate_property($AnimatedSprite3D, "modulate", Color(1, 0.5, 0.5, 1), Color(1, 1, 1, 1), 0.3, Tween.TRANS_QUART, Tween.EASE_IN)
	$Tween.start()
	
	$ASP3.stream = hitSound
	$ASP3.play()
	
	life -= damage
	
	if life < 0:
		death()


func _on_Timer_timeout():
	if attack:
		doAtk()
	else:
		$AnimatedSprite3D.play("move")
	pass # Replace with function body.
