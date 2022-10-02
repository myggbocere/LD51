extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.shoot.connect(generate_bullet)
	pass # Replace with function body.
func generate_bullet():
	var bulletScene = load("res://Scenes/Bullet.tscn")
	var bullet = bulletScene.instantiate()
	bullet.init(get_local_mouse_position() - $Player.position, $Player.position, $Player)
	add_child(bullet)
	bullet.check_hit()
#	print(str(self.get_child_count()))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
