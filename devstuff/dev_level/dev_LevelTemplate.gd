extends Node2D
class_name DevLevelTemplate

enum {POWER_NONE, POWER_GUN, POWER_SWORD, POWER_WINGS, POWER_FASTBOOTS, POWER_DASH}

var maps := []
var logic_nodes := []
var levers := []
var active_map := -1
var active_power = POWER_NONE
signal end_level()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(16): #I presume 16 logic levels will be more than enough
		logic_nodes.append([])
		levers.append([])
	var j = 0
	for svpcontainer in $BoxContainer.get_children():
		var m = svpcontainer.get_child(0).get_child(0)
		m.level_won.connect(level_won)
		m.process_mode = Node.PROCESS_MODE_DISABLED
		m.get_node("LogicContainer/TileMap").material = ShaderMaterial.new()
		m.get_node("LogicContainer/TileMap").material.shader = load("res://Shaders/" + str(j) + "Tile.gdshader")
#		print("res://Shaders/" + str(j) + "Tile.gdshader")
#		m.get_node("LogicContainer/TileMap").material = newmaterial
#		for layer in range(m.get_node("LogicContainer/TileMap").get_layers_count()):
#			for cell in m.get_node("LogicContainer/TileMap").get_used_cells(layer):
#				m.get_node("LogicContainer/TileMap").get_cell_tile_data(layer, cell).material = newmaterial
#		m.get_node("LogicContainer").shade_logic_tiles()
		maps.append(m)
		m.connect("time_up", map_time_up.bind(maps.size()-1))
		m.toggle_logic.connect(toggle_logic)
		m.get_node("Player").use_power.connect(use_power)
		m.get_node("Player").stop_use.connect(stop_power)
		m.get_node("Player").change_power.connect(change_power)
		for logic_node in m.get_node("LogicContainer").get_children():
			if "logic_levels" in logic_node:
				for i in logic_node.logic_levels:
					logic_nodes[i].append(logic_node)
					if logic_node.has_method("toggle_switch"):
						levers[i].append(logic_node)
		j += 1
#	for svpcontainer in $VBoxContainer.get_children():
#		var m = svpcontainer.get_child(0).get_child(0)
#		m.process_mode = Node.PROCESS_MODE_DISABLED
#		maps.append(m)
#		m.connect("time_up", map_time_up.bind(maps.size()-1))
#		m.get_node("Player").use_power.connect(use_power)
#		m.get_node("Player").stop_use.connect(stop_power)
#		m.get_node("Player").change_power.connect(change_power)
#		for logic_node in m.get_node("LogicContainer").get_children():
#			if "logic_levels" in logic_node:
#				for i in logic_node.logic_levels:
#					logic_nodes[i].append(logic_node)
#					if logic_node.has_method("toggle_switch"):
#						levers[i].append(logic_node)
	activate_map(0)
	pass # Replace with function body.
	
func level_won():
	emit_signal("end_level")
	
func stop_power():
	for map in maps:
		var player = map.get_node("Player")
		match active_power:
			POWER_NONE:
				pass
			POWER_GUN:
				player.stop_attack()
				pass
			POWER_SWORD:
				pass
			POWER_WINGS:
				pass
			POWER_FASTBOOTS:
				pass
			POWER_DASH:
				pass
func use_power():
	for map in maps:
		var player = map.get_node("Player")
		match active_power:
			POWER_NONE:
				pass
			POWER_GUN:
				player.stop_attack()
			POWER_SWORD:
				pass
			POWER_WINGS:
				pass
			POWER_FASTBOOTS:
				pass
			POWER_DASH:
				player.dash()

func change_power(power):
	print(power)
	for map in maps:
		var player = map.get_node("Player")
		player.is_flying = false
		match power:
			POWER_NONE:
				pass
			POWER_GUN:
				pass
			POWER_SWORD:
				pass
			POWER_WINGS:
				player.is_flying = true
			POWER_FASTBOOTS:
				pass
			POWER_DASH:
				pass
	active_power = power

func toggle_logic(level):
	for svpcontainer in $BoxContainer.get_children():
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
#	print(active_power)
	pass
