extends Node2D

const Alien = preload("res://Scenes/Alien.tscn")
onready var spawn1 = $"/root/Main/Spawn1"
onready var spawn2 = $"/root/Main/Spawn2"
var spawnTimer = 5
var spawnDelay = 2

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	spawnTimer -= delta
	if spawnTimer <= 0:
		spawn()
		spawnTimer = spawnDelay


func spawn():
	var new = Alien.instance()
	add_child(new)
	var which = randi() % 2
	if which == 0:
		new.position = spawn1.position
	else:
		new.position = spawn2.position
