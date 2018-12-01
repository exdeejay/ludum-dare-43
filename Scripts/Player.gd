extends KinematicBody2D

export var speed = 50
export var top_speed = 500
export var jump_speed = 500
export var gravity = 980

var velocity = Vector2()
var acceleration = Vector2()

const bullet = preload("res://Scenes/Bullet.tscn")

onready var camera = get_node("/root/Main/Camera2D")
onready var gun_anchor = $GunAnchor
onready var gun = $GunAnchor/Gun
onready var bullet_spawn = $GunAnchor/Gun/BulletSpawn
onready var bullet_container = $"/root/Main/Bullets"


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed == true and event.button_index == BUTTON_LEFT:
			fire_bullet(bullet_spawn.global_position, Vector2(1, 0).rotated(gun_anchor.rotation))


func _process(delta):
	gun_anchor.look_at(get_global_mouse_position())
	if cos(gun_anchor.rotation) < 0:
		gun.flip_v = true
	else:
		gun.flip_v = false


func _physics_process(delta):
	velocity.y += gravity * delta
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_speed
	
	var right_pressed = Input.is_action_pressed("ui_right")
	var left_pressed = Input.is_action_pressed("ui_left")
	if right_pressed:
		velocity.x += speed
	if left_pressed:
		velocity.x -= speed
	if not right_pressed and not left_pressed:
		velocity.x += -speed * sign(velocity.x)
	
	velocity.x = clamp(velocity.x, -top_speed, top_speed)
	velocity = move_and_slide(velocity, Vector2(0, -1))


func fire_bullet(position, direction):
	var new_bullet = bullet.instance()
	bullet_container.add_child(new_bullet)
	new_bullet.position = position
	new_bullet.direction = direction
	camera.shake(10, 0.1)
