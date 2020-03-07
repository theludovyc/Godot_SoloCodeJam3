extends StaticBody


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
	
#	pass
