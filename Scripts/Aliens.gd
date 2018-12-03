extends Node2D

const Graph = preload("res://Scripts/Graph.gd")
onready var platforms = $"/root/Main/Platforms"
onready var graph = Graph.new(40, 40, 64, platforms)

const TileNode = preload("res://Scenes/TileNode.tscn")
const Alien = preload("res://Scenes/Alien.tscn")
onready var spawn1 = $"/root/Main/Spawn1"
onready var spawn2 = $"/root/Main/Spawn2"
onready var spawn3 = $"/root/Main/Spawn3"
var spawnTimer = 2
var spawnDelay = 2

#func _ready():
#	for t in graph.tiles:
#		var new = TileNode.instance()
#		add_child(new)
#		new.position = t.position * graph.tile_size + Vector2(graph.tile_size/2, graph.tile_size/2)


func _process(delta):
	spawnTimer -= delta
	if spawnTimer <= 0:
		spawn()
		spawnTimer = spawnDelay


#func _draw():
#	var t = graph.tiles[36]
#	for n in t.neighbors:
#		draw_line(t.position * 64 + Vector2(32, 32), n.position * 64 + Vector2(32, 32), ColorN("black"))
#	if path:
#		for i in range(path.size()):
#			if i != path.size() - 1:
#				draw_line(path[i].position * 32, path[i+1].position*32, ColorN("black"))


func spawn():
	var new = Alien.instance()
	add_child(new)
	var which = randi() % 3
	match which:
		0:
			new.position = spawn1.position
		1:
			new.position = spawn2.position
		2:
			new.position = spawn3.position
