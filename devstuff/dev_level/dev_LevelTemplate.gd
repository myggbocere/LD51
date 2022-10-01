extends Node2D
class_name DevLevelTemplate
# add an array to contain maps to cycle through, and helper functions to switch maps (applying color washout filter, disabling processing, etc) and get next non-complete map's color for time bar
var maps := []
var active_map = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for svpcontainer in $BoxContainer.get_children():
		var m = svpcontainer.get_child(0).get_child(0)
		m.process_mode = Node.PROCESS_MODE_DISABLED
		maps.append(m)
		m.connect("time_up", map_time_up.bind(maps.size()-1))
#	activate_map(0)
	activate_map(0)
	pass # Replace with function body.

func map_time_up(idx):
	var done := false
	while not done:
		idx += 1
		if idx < maps.size():
			pass
		else:
			idx = 0
		if not maps[idx].is_complete:
			activate_map(idx)
			done = true

func activate_map(idx):
	active_map = idx
	maps[idx].print_tree_pretty()
	if maps[idx].has_method("activate"):
		print("bruh")
		maps[idx].activate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
