extends Node2D
class_name DevMapTemplate

var is_complete := false
var is_active := false
var counters := []
var seconds:int
signal time_up()

const emptycounter = preload("res://devstuff/dev_level/empty_counter.png")
const tealcounter = preload("res://devstuff/dev_level/teal_counter.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	for counter in $for_zorder/HSplitContainer.get_children():
		counters.append(counter)
	seconds = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate():
	process_mode = PROCESS_MODE_INHERIT
	for counter in counters:
		counter.texture = emptycounter
	$Timer.start(1)

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
