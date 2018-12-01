extends Area2D

export var speed = 20
var direction = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	position += direction * speed
