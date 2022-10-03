extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range($container.get_children().size()):
		$container.get_children()[i].end_level.connect(end_level.bind(i))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_node("Level Select").visible = true
	get_node("Level Select").process_mode = PROCESS_MODE_ALWAYS
	$Control.visible = false
	pass # Replace with function body.


func _on_button1_pressed():
	$AudioStreamPlayer.playing = false
	$AudioStreamPlayer2.playing = true
	$Control.visible = false
	get_node("Level Select").visible = false
	$Control.process_mode = PROCESS_MODE_DISABLED
	get_node("Level Select").process_mode = PROCESS_MODE_DISABLED
	get_node("container/0-1").visible = true
	get_node("container/0-1").process_mode = PROCESS_MODE_ALWAYS
	pass # Replace with function body.


func _on_button_2_pressed():
	$AudioStreamPlayer.playing = false
	$AudioStreamPlayer2.playing = true
	$Control.visible = false
	get_node("Level Select").visible = false
	$Control.process_mode = PROCESS_MODE_DISABLED
	get_node("Level Select").process_mode = PROCESS_MODE_DISABLED
	get_node("container/0-2").visible = true
	get_node("container/0-2").process_mode = PROCESS_MODE_ALWAYS
	pass # Replace with function body.


func _on_button_3_pressed():
	$AudioStreamPlayer.playing = false
	$AudioStreamPlayer2.playing = true
	$Control.visible = false
	get_node("Level Select").visible = false
	$Control.process_mode = PROCESS_MODE_DISABLED
	get_node("Level Select").process_mode = PROCESS_MODE_DISABLED
	get_node("container/0-3").visible = true
	get_node("container/0-3").process_mode = PROCESS_MODE_ALWAYS
	pass # Replace with function body.

func end_level(level):
	$container.get_child(level).visible = false
	$container.get_child(level).process_mode = PROCESS_MODE_DISABLED
	$Control.visible = true
	$Control.process_mode = PROCESS_MODE_ALWAYS
	
	if get_node("Level Select").get_child(level).text.length() < 10:
		get_node("Level Select").get_child(level).text = get_node("Level Select").get_child(level).text + " (beaten)"
	get_node("Level Select").get_child(0).pressed.connect(_on_button1_pressed)
	get_node("Level Select").get_child(1).pressed.connect(_on_button_2_pressed)
	get_node("Level Select").get_child(2).pressed.connect(_on_button_3_pressed)
