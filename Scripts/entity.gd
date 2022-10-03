class_name Entity

extends CharacterBody2D
const friction = 12
const ACCEL_RATE = 60
var entityScene = load("res://Scenes/entity.tscn")
var health;
var direction:Vector2 = Vector2(0,0)
var hittable = {}
var fall_next_frame = false
var falling = false
var seconds_since_falling = 0.0
var is_flying := false
@onready var original_scale = scale

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
		
func fall_to_death(delta):
	velocity = Vector2.ZERO
	direction = Vector2.ZERO
	set_process_input(false)
	seconds_since_falling += delta
	scale = original_scale*(1 - seconds_since_falling)
	rotation += delta*PI/4
	if seconds_since_falling > 1:
		kill()
	pass
	
func kill():
	queue_free()
	pass
		
func apply_friction(delta):
	velocity *= 1.0 - (friction * delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fall_next_frame:
		fall_to_death(delta)
		return
	apply_accel(ACCEL_RATE)
	if velocity.length() > 0:
		move_and_slide()
		apply_friction(delta)
		
		
