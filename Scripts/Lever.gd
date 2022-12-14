extends LogicNode
class_name Lever


#better to have it and not need it
signal switched_on()
signal switched_off()
signal switched()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2d.material = ShaderMaterial.new()
	$AnimatedSprite2d.material.shader = load("res://Shaders/" + str(logic_levels[0]) + "Lever.gdshader")
	#call function to texture based on logic level
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func switch_off():
	$AnimatedSprite2d.frame = 0
	emit_signal("switched_off")
	emit_signal("switched")
	pass
	
func switch_on():
	$AnimatedSprite2d.frame = 1
	emit_signal("switched_on")
	emit_signal("switched")
	pass
	
func toggle_switch():
	if $AnimatedSprite2d.frame == 0:
		switch_on()
	else:
		switch_off()
	pass

func toggle(_level:int):
	toggle_switch()
