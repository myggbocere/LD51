extends LogicNode
var logic_tiles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(16):
		logic_tiles.append([])
	for layer in range($TileMap.get_layers_count()):
		for cell in $TileMap.get_used_cells(layer):
			if $TileMap.get_cell_tile_data(layer, cell).terrain_set > 0:
				logic_tiles[$TileMap.get_cell_tile_data(layer, cell).terrain].append([cell, layer])
		pass
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func toggle(level:int):
	for child in get_children():
		if child.has_method("toggle"):
			child.toggle(level)
	toggle_tilemap(level)
	
func toggle_tilemap(level:int):
	var tiles_on = []
	var tiles_off = []
	for layers in range($TileMap.get_layers_count()):
		tiles_on.append([])
		tiles_off.append([])
	for tuple in logic_tiles[level]:
		if $TileMap.get_cell_tile_data(tuple[1], tuple[0]).terrain_set == 1:
			tiles_off[tuple[1]].append(tuple[0])
			pass
		else:
			tiles_on[tuple[1]].append(tuple[0])
			pass
		pass
	for layer in range($TileMap.get_layers_count()):
		$TileMap.set_cells_terrain_connect(layer, tiles_on[layer], 1, level)
		$TileMap.set_cells_terrain_connect(layer, tiles_off[layer], 2, level)
	pass
