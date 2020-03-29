extends StaticBody

const SPEED = 6.0

var hitSound = preload("res://Art/Skull/dsmandth.wav")
var deathSound = preload("res://Art/Sound/dsbarexp.wav")

var life:float = 10

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

func death():
	$CollisionShape.disabled = true
	
	$AnimatedSprite3D.play("death")
	
	$ASP3.stream = deathSound
	$ASP3.play()
	
	$T_Move.stop_all()
	
	$Tween.interpolate_property($AnimatedSprite3D, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.25, Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.start()
	
	$Timer.start()
	
	follow = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var p_t = get_parent().get_player().translation
	
	var dir = translation.direction_to(p_t)
	
	rotation.y = atan2(dir.x, dir.z)
	
	if follow:
		if translation.distance_to(p_t) > 1.5:
			translation += Vector3(dir.x, 0, dir.z) * delta * SPEED
		else:
			death()

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
	var phy = PhysicsShapeQueryParameters.new()
	
	var shape = CylinderShape.new()
	shape.radius = 2
	shape.height = 0.3
	
	phy.transform.origin = translation
	phy.set_shape(shape)
	
	var result = get_world().direct_space_state.intersect_shape(phy)
	
	for r in result:
		if r.collider.is_in_group("Livers"):
			r.collider.doHit(DAMAGE)
