class_name Entity

extends CharacterBody2D
var entityScene = load("res://Scenes/entity.tscn")
var health
const friction = 7
const ACCEL_RATE = 200

func apply_accel(direction:Vector2):
	direction = direction.normalized()
	velocity += direction * ACCEL_RATE
func _init():
	health = 100
# Called when the node enters the scene tree for the first time.
func _ready():
#	if not added:
#		var entit = entityScene.instantiate()
#		entit.added = true
#		self.add_child(entit)
	pass # Replace with function body.
func _input(event):
	var direction:Vector2 = Vector2(0,0)
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	apply_accel(direction)
	
func apply_friction(delta):
	velocity *= 1.0 - (friction * delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.length() > 0:
		move_and_slide()
		apply_friction(delta)

		
		
