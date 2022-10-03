extends Entity

var attack_timer = Timer.new()
var enemy
var ray:RayCast2D = null

func try_shoot():
	if ray == null:
		ray = RayCast2D.new()
		ray.collision = true
		ray.collide_with_areas = true
		ray.position = position
		ray.target_position = enemy.position
	ray.force_raycast_update()
	var hit = ray.get_collider()
	if hit != enemy:
		navigate(enemy)
	else:
		attack()

func attack():
	var bulletScene = load("res://Scenes/Bullet.tscn")
	var bullet = bulletScene.instantiate()
	bullet.init(enemy.position - position, position, self)
	get_parent().add_child(bullet)
	bullet.check_hit()
func navigate(enemy):
	$NavigationAgent2d.set_target_location(enemy.position)
	position = $NavigationAgent2d.get_next_location()
func _ready():
	attack_timer.connect("timeout", attack)
	attack_timer.wait_time = .1
	add_child(attack_timer)
func _process(delta):
	pass
