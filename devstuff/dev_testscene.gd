extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#	print(str(self.get_child_count()))
func generate_enemies():
	var mobs = load("res://Scenes/mob.tscn")
	var mob = mobs.instantiate()
	mob
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
