extends LogicNode
var logic_tiles = []
var materials = []
var tilemaps = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var i = 0
	for newtm in $TileMap.get_children():
		var newshader = load("res://Shaders/" + str(i) + "Tile.gdshader")
		var newmaterial = ShaderMaterial.new()
		newmaterial.shader = newshader
		materials.append(newmaterial)
		#newtm.tile_set = load("res://tilesets/logic_resources/" + str(i) + "mapart.tres")
		newtm.material = newmaterial
		newtm.material.shader = load("res://Shaders/" + str(i) + "Tile.gdshader")
		newtm.z_index = 1
		tilemaps.append(newtm)
		logic_tiles.append([])
		i += 1
#	for cell in $TileMap.get_used_cells(3):
#		if $TileMap.get_cell_tile_data(2, cell).terrain_set > 0:
#			logic_tiles[$TileMap.get_cell_atlas_coords(3, cell).y*8 + $TileMap.get_cell_atlas_coords(3, cell).x].append(cell)
#
#		pass
#	var tiles_on = []
#	var tiles_off = []
#	var pps_on = []
#	var pps_off = []
#	var tds_on = []
#	var tds_off = []
#	for level in range(logic_tiles.size()):
#		for cell in logic_tiles[level]:
#			match $TileMap.get_cell_tile_data(2, cell).terrain_set:
#				1:
#					tiles_off.append(cell)
#				3:
#					pps_off.append(cell)
#				5:
#					tds_off.append(cell)
#				2:
#					tiles_on.append(cell)
#				4:
#					pps_on.append(cell)
#				6:
#					tds_on.append(cell)
#		for j in tilemaps[level].tile_set.get_terrain_sets_count():
#			print(tilemaps[level].tile_set.get_terrains_count(j))
#		tilemaps[level].set_cells_terrain_connect(2, tiles_on, 2, 0)
#		for tile in tiles_on:
#			print(tile)
#			tilemaps[level].set_cell(2, tile, $TileMap.get_cell_source_id(2, tile).get_tile_id(), Vector2i(9,0))
#		tilemaps[level].set_cells_terrain_connect(2, tiles_off, 1, 0)
#		for tile in tiles_off:
#			print(tile)
#			tilemaps[level].set_cell(2, tile, $TileMap.get_cell_source_id(2, tile), Vector2i(5,1))
#		tilemaps[level].set_cells_terrain_connect(2, pps_on, 4, 0)
#		tilemaps[level].set_cells_terrain_connect(2, pps_off, 3, 0)
#		tilemaps[level].set_cells_terrain_connect(2, tds_on, 6, 0)
#		tilemaps[level].set_cells_terrain_connect(2, tds_off, 5, 0)
#	$TileMap.set_visible(false)
	for map in $TileMap.get_children():
#		map.set_visible(true)
#		print(map.is_visible())
		for cell in map.get_used_cells(2):
			pass
	for cell in $TileMap.get_used_cells(3):
		if $TileMap.get_cell_tile_data(2, cell).terrain_set > 0:
			$TileMap.erase_cell(2, cell)
	
	print_tree_pretty()
	#shade_logic_tiles()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shade_logic_tiles():
	for arr in logic_tiles:
		for tuple in arr:
			var cell = tuple[0]
			#if $TileMap.get_cell_source_id(3, cell) == 6:
			var newmaterial = ShaderMaterial.new()
			newmaterial.shader = load("res://Shaders/" + str($TileMap.get_cell_atlas_coords(3, cell).y*8 + $TileMap.get_cell_atlas_coords(3, cell).x) + "Tile.gdshader")
			$TileMap.get_cell_tile_data(2, cell).set_material(newmaterial)
	pass

func toggle(level:int):
	for child in get_children():
		if child.has_method("toggle"):
			child.toggle(level)
	toggle_tilemap(level)
	
func toggle_tilemap(level:int):
	var tiles_on = []
	var tiles_off = []
	var pps_on = []
	var pps_off = []
	var tds_on = []
	var tds_off = []
	for child in $TileMap.get_children():
		for cell in child.get_used_cells(2):
			if not is_instance_valid($TileMap.get_child(level).get_cell_tile_data(2, cell)):
				continue
			match $TileMap.get_child(level).get_cell_tile_data(2, cell).terrain_set:
				1:
					tiles_off.append(cell)
				3:
					pps_off.append(cell)
				5:
					tds_off.append(cell)
				2:
					tiles_on.append(cell)
				4:
					pps_on.append(cell)
				6:
					tds_on.append(cell)
		$TileMap.get_child(level).set_cells_terrain_connect(2, tiles_on, 1, 0)
#			for tile in tiles_off:
#				tilemaps[level].set_cell(2, tile, 5, Vector2i(9,0))
		$TileMap.get_child(level).set_cells_terrain_connect(2, tiles_off, 2, 0)
#			for tile in tiles_on:
#				tilemaps[level].set_cell(2, tile, 5, Vector2i(5,1))
		$TileMap.get_child(level).set_cells_terrain_connect(2, pps_on, 3, 0)
		$TileMap.get_child(level).set_cells_terrain_connect(2, pps_off, 4, 0)
		$TileMap.get_child(level).set_cells_terrain_connect(2, tds_on, 5, 0)
		$TileMap.get_child(level).set_cells_terrain_connect(2, tds_off, 6, 0)
	pass
