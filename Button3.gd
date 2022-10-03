extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_3_pressed():
	get_parent().visible = false
	get_child(0).visible = true
	get_parent().process_mode = PROCESS_MODE_DISABLED
	get_child(0).process_mode = PROCESS_MODE_ALWAYS
	pass # Replace with function body
	pass # Replace with function body.
