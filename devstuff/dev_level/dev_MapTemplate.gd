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
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
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
	print(levers_in_range)
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
