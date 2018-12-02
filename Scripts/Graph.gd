class GraphTile:
	var position
	var cost
	var neighbors

export var runspeed = 250
export var jumpspeed = 560
export var gravity = 980

var tiles = []
var num_tiles_x
var num_tiles_y
var tile_size
var environment

func _init(tiles_x, tiles_y, size, env):
	num_tiles_x = tiles_x
	num_tiles_y = tiles_y
	tile_size = size
	environment = env
	for x in range(-num_tiles_x, num_tiles_x):
		for y in range(-num_tiles_y, num_tiles_y):
			var x_coord = x * tile_size
			var y_coord = y * tile_size
			for node in environment.get_children():
				var extents = node.get_child(1).shape.extents
				if node.position.x - extents.x < x_coord and x_coord < node.position.x + extents.x:
					if node.position.y - extents.y < y_coord and y_coord < node.position.y + extents.y:
						var new_tile = GraphTile.new()
						new_tile.position = Vector2(x, y - 1)
						tiles.append(new_tile)
	for t in tiles:
		t.cost = cost(t)
		t.neighbors = neighbors(t)


func neighbors(tile):
	var neighbors = []
	for t in tiles:
		var dx = abs(t.position.x * 32 - tile.position.x * 32)
		var dy = t.position.y * 32 - tile.position.y * 32
		if dy >= 0.5*gravity*(dx/runspeed) - jumpspeed*(dx/runspeed):
			neighbors.append(t)
	return neighbors


func cost(end):
	var x = end.position.x * tile_size
	var y = end.position.y * tile_size
	for node in environment.get_children():
		var extents = node.get_child(1).shape.extents
		if node.position.x - extents.x < x and x < node.position.x + extents.x:
			if node.position.x - extents.x < x and x < node.position.x + extents.x:
				return 0
	return 1
