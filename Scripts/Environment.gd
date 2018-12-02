extends Node2D

const TileNode = preload("res://Scenes/TileNode.tscn")
const Graph = preload("res://Scripts/Graph.gd")
onready var graph = Graph.new(40, 40, 32, self)

var path


#func _ready():
#	for t in graph.tiles:
#		var node = TileNode.instance()
#		add_child(node)
#		node.position = t.position * 32


#func _process(delta):
#	update()


#func _draw():
#	for t in graph.tiles:
#		for n in t.neighbors:
#			if n.position.x == t.position.x:
#				draw_line(t.position * 32, n.position * 32, ColorN("black"))
#	if path:
#		for i in range(path.size()):
#			if i != path.size() - 1:
#				draw_line(path[i].position * 32, path[i+1].position*32, ColorN("black"))
