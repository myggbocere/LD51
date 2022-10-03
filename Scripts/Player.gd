extends Entity
const DASH_TIMER = 500
const DASH_SPEED = 450
var clicked:bool = false
var mouse_direction:Vector2 = Vector2(0,0)
var attack_timer = Timer.new()
var prev_dash = 0
signal shoot()
signal interact()
# Called when the node enters the scene tree for the first time.
func _ready():
	attack_timer.connect("timeout", attack)
	attack_timer.wait_time = .1
	add_child(attack_timer)
	pass
func attack():
	emit_signal("shoot")
	pass
func dash():
		var curr_time = Time.get_unix_time_from_system() * 1000
		if curr_time - prev_dash >= DASH_TIMER:
			apply_accel(DASH_SPEED)
			prev_dash = curr_time

func _input(event):
	#print(event.as_text() + " " + str(self.position))
	var dir:Vector2 = Vector2(0,0)
	dir.x = Input.get_axis("left", "right")
	dir.y = Input.get_axis("up", "down")
	self.direction = dir
	if event.is_action_pressed("press"):	
		attack_timer.start()
	elif event.is_action_released("press"):
		attack_timer.stop()
	elif event.is_action_pressed("dash"):
		dash()
	elif event.is_action_pressed("interact"):
		emit_signal("interact")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
