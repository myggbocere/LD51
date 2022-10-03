extends Entity

var attack_timer = Timer.new()
var navigation_timer = Timer.new()
var enemies = []
var rays = []
func add_enemies(enem):
	enemies = enem
	for enemy in enemies:
		rays.append(RayCast2D.new())
		rays[-1].collision = true
		rays[-1].collide_with_areas = true
		rays[-1].set_cast_to(enemy.position)

func navigate():
	pass
func _ready():
#	navigation_timer.connect("timeout",)
	pass
func _process(delta):
	pass
