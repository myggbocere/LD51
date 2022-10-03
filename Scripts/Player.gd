extends Entity
const DASH_TIMER = 500
const DASH_SPEED = 450

@export var spawn_point = Vector2(0,0)

var clicked:bool = false
var mouse_direction:Vector2 = Vector2(0,0)
var attack_timer = Timer.new()
var prev_dash = 0
signal interact()
signal use_power()
signal stop_use()
signal change_power(power:int)
signal pick_up()
# Called when the node enters the scene tree for the first time.
func attack():
	attack_timer.start()
func stop_attack():
	attack_timer.stop()
func shoot():
	var bulletScene = load("res://Scenes/Bullet.tscn")
	var bullet = bulletScene.instantiate()
	bullet.init(get_local_mouse_position() - position, position, self)
	get_parent().add_child(bullet)
	bullet.check_hit()
func _ready():
	respawn()
	attack_timer.connect("timeout", shoot)
	attack_timer.wait_time = .1
	add_child(attack_timer)
	
	pass
func dash():
		var curr_time = Time.get_unix_time_from_system() * 1000
		
		if curr_time - prev_dash >= DASH_TIMER:
			apply_accel(DASH_SPEED)
			prev_dash = curr_time
			get_tree().create_timer(DASH_SPEED/2000.0).timeout.connect(remove_dash_fall_immunity)
			is_flying = true
			
func remove_dash_fall_immunity():
	print("timed out")
	is_flying = false

func kill():
	respawn()

func respawn():
	scale = original_scale
	position = spawn_point
	rotation = 0
	fall_next_frame = false
	seconds_since_falling = 0
	set_process_input(true)
	emit_signal("change_power", DevLevelTemplate.POWER_NONE)

func _input(event):
	#print(event.as_text() + " " + str(self.position))
	var dir:Vector2 = Vector2(0,0)
	dir.x = Input.get_axis("left", "right")
	dir.y = Input.get_axis("up", "down")
	self.direction = dir
	if dir.x != 0:
		if dir.x < 0:
			$AnimatedSprite2d.frame = 1
			$AnimatedSprite2d.scale = Vector2(4, 4)
		else:
			$AnimatedSprite2d.frame = 1
			$AnimatedSprite2d.scale = Vector2(-4, 4)
	elif dir.y != 0:
		if dir.y > 0:
			$AnimatedSprite2d.frame = 2
		else:
			$AnimatedSprite2d.frame = 3
	else:
		$AnimatedSprite2d.frame = 0
	if event.is_action_pressed("press"):	
		use()
	elif event.is_action_released("press"):
		stop()
#	elif event.is_action_pressed("dash"):
#		dash()
	elif event.is_action_pressed("interact"):
		emit_signal("interact")
	elif event.is_action_pressed("pick_up"):
		emit_signal("pick_up")
		
func use():
	emit_signal("use_power")
func stop():
	emit_signal("stop_use")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
