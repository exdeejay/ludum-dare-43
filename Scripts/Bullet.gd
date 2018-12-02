extends Area2D

const Alien = preload("res://Scripts/Alien.gd")

export var speed = 20
export var threshold = 20 * 32
var direction = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	position += direction * speed
	if abs(position.x) > threshold or abs(position.y) > threshold:
		queue_free()


func _on_Bullet_body_entered(body):
	if body is Alien:
		body.on_kill()
		body.queue_free()
		queue_free()
