extends Camera2D

var shake_amount = 0
var shake_duration = 0
var shake_time_left = 0

onready var player = $"/root/Main/Player"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _process(delta):
	position = player.position
	update_shake(delta)


func update_shake(delta):
	if shake_time_left <= 0:
		offset = Vector2()
		return
	
	shake_time_left -= delta
	var current_amount = shake_amount * (shake_time_left / shake_duration)
	var rot = randf() * 360
	offset = Vector2(0, 1).rotated(rot * 180 / PI) * current_amount


func shake(amount, duration):
	shake_amount = amount
	shake_duration = duration
	shake_time_left = shake_duration
