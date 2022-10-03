extends Node2D
class_name DevMapTemplate

var is_complete := false
var is_active := false
var counters := []
var seconds:int
signal time_up()
signal toggle_logic(level:int)

var levers_in_range := []
var closest_lever = null

const emptycounter = preload("res://devstuff/dev_level/empty_counter.png")
const tealcounter = preload("res://devstuff/dev_level/teal_counter.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	for counter in $for_zorder/HSplitContainer.get_children():
		counters.append(counter)
	seconds = 0
	$Player.interact.connect(on_player_interact)
	for lnode in $LogicContainer.get_children():
		if lnode.has_method("toggle_switch"):
			lnode.get_node("Hitbox").body_entered.connect(lever_area_entered.bind(lnode))
			lnode.get_node("Hitbox").body_exited.connect(lever_area_exited.bind(lnode))
#	$Player.shoot.connect(generate_bullet)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var entities = $EntityContainer.get_children()
	entities.append($Player)
	for entity in entities:
		if $LogicContainer/TileMap.get_cell_tile_data(0, $LogicContainer/TileMap.local_to_map(entity.position)).terrain == 0:
			if (not entity.fall_next_frame) and (not entity.is_flying):
				entity.fall_next_frame = true
				print("did the thing")
			pass
	pass

func activate():
	process_mode = PROCESS_MODE_INHERIT
	for counter in counters:
		counter.texture = emptycounter
	$Timer.start(1)

func lever_area_entered(body, lever):
	if body == $Player:
		levers_in_range.append(lever)
		scale_levers()

func lever_area_exited(body, lever):
	if body == $Player:
		levers_in_range.erase(lever)
		scale_levers()
	pass

func scale_levers():
	if closest_lever != null:
		closest_lever.get_node("AnimatedSprite2d").scale = Vector2(1,1)
	closest_lever = null
	for lever in levers_in_range:
		if closest_lever == null or ((closest_lever.position - $Player.position).length() > (lever.position - $Player.position).length()):
			closest_lever = lever
	if closest_lever != null:
		closest_lever.get_node("AnimatedSprite2d").scale = Vector2(1.5,1.5)

func on_player_interact():
	if closest_lever != null:
		emit_signal("toggle_logic", closest_lever.logic_levels[0])
	pass

func generate_bullet():
	var bulletScene = load("res://Scenes/Bullet.tscn")
	var bullet = bulletScene.instantiate()
	bullet.init(get_local_mouse_position() - $Player.position, $Player.position, $Player)
	add_child(bullet)
	bullet.check_hit()

func _on_timer_timeout():
	seconds += 1
	if seconds < 10:
		counters[seconds - 1].texture = tealcounter
		$Timer.start(1)
	else:
		seconds = 0
		emit_signal("time_up")
		process_mode = PROCESS_MODE_DISABLED
	pass # Replace with function body.
