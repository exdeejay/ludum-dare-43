extends Node2D

const Graph = preload("res://Scripts/Graph.gd")
onready var platforms = $"/root/Main/Platforms"
onready var graph = Graph.new(40, 40, 64, platforms)

const Alien = preload("res://Scenes/Alien.tscn")
onready var spawn1 = $"/root/Main/Spawn1"
onready var spawn2 = $"/root/Main/Spawn2"
onready var spawn3 = $"/root/Main/Spawn3"
var spawnTimer = 2
var spawnDelay = 2


func _process(delta):
	spawnTimer -= delta
	if spawnTimer <= 0:
		spawn()
		spawnTimer = spawnDelay


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
