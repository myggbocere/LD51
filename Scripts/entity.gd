class_name Entity

extends CharacterBody2D
#var entityScene = load("res://Scenes/entity.tscn")
var health
var friction = .6
var accel = {"up":Vector2(0,-10), 
"down":Vector2(0,10), 
"left":Vector2(-10,0),
"right":Vector2(10,0)}

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
	print(event.as_text())
	for direction in accel:
		if velocity.length() > 500:
			break
		if event.is_action(direction):
			velocity += accel[direction]
func apply_friction(delta):
	velocity *= friction * delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.length() > 0:
		move_and_slide()
		apply_friction(delta)
		
		
