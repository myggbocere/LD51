extends Camera2D
const ZOOM_INCREMENT_VEC = Vector2(1.2, 1.2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("level_zoom_in") and (zoom*ZOOM_INCREMENT_VEC).x < 20: #use x because they'll always be the same and easier than comparing vectors
		zoom *= ZOOM_INCREMENT_VEC
		print(zoom)
	elif event.is_action_pressed("level_zoom_out") and (zoom/ZOOM_INCREMENT_VEC).x > 1.2:
		zoom /= ZOOM_INCREMENT_VEC
		print(zoom)
