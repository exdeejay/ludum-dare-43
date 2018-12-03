class GraphTile:
	var position
	var cost
	var neighbors

export var runspeed = 250
export var jumpspeed = 790
export var gravity = 980

var tiles = []
var num_tiles_x
var num_tiles_y
var tile_size
var tilemap

func _init(tiles_x, tiles_y, size, map):
	num_tiles_x = tiles_x
	num_tiles_y = tiles_y
	tile_size = size
	tilemap = map
	for x in range(-num_tiles_x, num_tiles_x):
		for y in range(-num_tiles_y, num_tiles_y):
			var tile_pos = tilemap.world_to_map(Vector2(x * tile_size, y * tile_size))
			var cell = tilemap.get_cell(tile_pos.x, tile_pos.y)
			var cell_above = tilemap.get_cell(tile_pos.x, tile_pos.y - 1)
			if cell != -1 and cell_above == -1:
				var new_tile = GraphTile.new()
				new_tile.position = Vector2(x, y - 1)
				tiles.append(new_tile)
	for t in tiles:
		t.cost = cost(t)
		t.neighbors = neighbors(t)


func neighbors(tile):
	var neighbors = []
	for t in tiles:
		if t == self:
			continue
		var dx = abs(t.position.x * tile_size - tile.position.x * tile_size)
		if t.position.y * tile_size >= 0.5 * gravity * pow(dx/runspeed, 2) - jumpspeed*(dx/runspeed) + tile.position.y * tile_size:
			neighbors.append(t)
	return neighbors


func cost(end):
	var x = end.position.x * tile_size
	var y = end.position.y * tile_size
	var tile_pos = tilemap.world_to_map(Vector2(x, y))
	var cell = tilemap.get_cell(tile_pos.x, tile_pos.y)
	if cell != -1:
		return 0
	return 1
