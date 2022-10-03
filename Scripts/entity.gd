class_name Entity

extends CharacterBody2D
const friction = 12
const ACCEL_RATE = 60
var entityScene = load("res://Scenes/entity.tscn")
var health;
var direction:Vector2 = Vector2(0,0)
var hittable = {}
func apply_accel(accel):
	direction = direction.normalized()
	velocity += direction * accel
func _init():
	health = 100
# Called when the node enters the scene tree for the first time.
func _ready():
#	if not added:
#		var entit = entityScene.instantiate()
#		entit.added = true
#		self.add_child(entit)
	pass # Replace with function body.
func get_hit():
	health -= 10
func try_hit(object):
	if hittable.has(object) and object.has_method("get_hit"):
		object.get_hit()
func apply_friction(delta):
	velocity *= 1.0 - (friction * delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	apply_accel(ACCEL_RATE)
	if velocity.length() > 0:
		move_and_slide()
		apply_friction(delta)

		
		
