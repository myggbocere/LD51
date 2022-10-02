extends RayCast2D
const MAX_DIST = 1000
const BULLET_SPEED = 3000

var velocity:Vector2 = Vector2(0,0)
var shooter:Entity;
func init(dir:Vector2, origin:Vector2, shot:Entity):
	position = origin
	self.shooter = shot
	dir = dir.normalized()
	target_position = origin + (dir * MAX_DIST)
	velocity = BULLET_SPEED * dir

func check_hit():
	var hit = get_collider()
	if hit != null:
		shooter.try_hit(hit)
		target_position = hit.position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var next_pos:Vector2 = position + velocity * delta
	if (position - next_pos).length() > (position - target_position).length():
		queue_free()
	else:
		position = next_pos
