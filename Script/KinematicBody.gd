extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed:Vector2

var haveMove := false

const SENSI = 0.5

const SPEED = 6

var dir:Vector3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		speed = event.relative
		haveMove=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if haveMove:
		rotate_y(-(speed.x*SENSI*delta))
	
		$Camera.rotate_x(speed.y*SENSI*delta)
		#$Camera.rotation = Vector3(clamp($Camera.rotation.x, deg2rad(-45), deg2rad(45) ), 0, 0)
		
		haveMove=false

	dir = Vector3(int(Input.is_action_pressed("ui_left"))-int(Input.is_action_pressed("ui_right")), 0, int(Input.is_action_pressed("ui_up"))-int(Input.is_action_pressed("ui_down")))

func _physics_process(delta):
	move_and_slide(dir.rotated(Vector3.UP, rotation.y).normalized()*SPEED)
