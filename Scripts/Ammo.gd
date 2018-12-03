extends Area2D

export var amount_worth = 10

onready var player = $"/root/Main/Player"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Ammo_body_entered(body):
	if body == player:
		player.energy += amount_worth
		queue_free()