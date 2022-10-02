extends Node2D
class_name DevLevelTemplate
# add an array to contain maps to cycle through, and helper functions to switch maps (applying color washout filter, disabling processing, etc) and get next non-complete map's color for time bar
var maps := []
var logic_nodes := []
var levers := []
var active_map = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(16): #I presume 16 logic levels will be more than enough
		logic_nodes.append([])
		levers.append([])
	for svpcontainer in $BoxContainer.get_children():
		var m = svpcontainer.get_child(0).get_child(0)
		m.process_mode = Node.PROCESS_MODE_DISABLED
		maps.append(m)
		m.connect("time_up", map_time_up.bind(maps.size()-1))
		m.toggle_logic.connect(toggle_logic)
		for logic_node in m.get_node("LogicContainer").get_children():
			if "logic_levels" in logic_node:
				for i in logic_node.logic_levels:
					logic_nodes[i].append(logic_node)
					if logic_node.has_method("toggle_switch"):
						levers[i].append(logic_node)
	for svpcontainer in $VBoxContainer.get_children():
		var m = svpcontainer.get_child(0).get_child(0)
		m.process_mode = Node.PROCESS_MODE_DISABLED
		maps.append(m)
		m.connect("time_up", map_time_up.bind(maps.size()-1))
		for logic_node in m.get_node("LogicContainer").get_children():
			if "logic_levels" in logic_node:
				for i in logic_node.logic_levels:
					logic_nodes[i].append(logic_node)
					if logic_node.has_method("toggle_switch"):
						levers[i].append(logic_node)
	activate_map(0)
	pass # Replace with function body.

func toggle_logic(level):
	for svpcontainer in $BoxContainer.get_children():
		var lc = svpcontainer.get_child(0).get_child(0).get_node("LogicContainer")
		lc.toggle(level)
	for svpcontainer in $VBoxContainer.get_children():
		var lc = svpcontainer.get_child(0).get_child(0).get_node("LogicContainer")
		lc.toggle(level)
	pass

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
	if maps[idx].has_method("activate"):
		maps[idx].activate()

func toggle(logic_layer):
	for svpcontainer in $BoxContainer.get_children():
		var lc = svpcontainer.get_child(0).get_child(0).get_node("LogicContainer")
		lc.toggle(logic_layer)
#	for logic_node in logic_nodes[logic_layer]:
#		logic_node.toggle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
