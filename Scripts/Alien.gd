extends KinematicBody2D

const PriorityQueue = preload("res://Scripts/PriorityQueue.gd")
const Ammo = preload("res://Scenes/Ammo.tscn")

export var speed = 50
export var top_speed = 250

export var jump_speed = 790
export var gravity = 980
export var top_fall_speed = 1960

export var path_cache_duration = 0.1

export var tile_threshold_x = 64
export var tile_threshold_y = 64
export var tile_time_threshold = 3

var move_left = false
var move_right = false
var jump = false
var velocity = Vector2()
var path
var path_cache_time = 0
var current_tile
var current_tile_time = 0

onready var sprite = $Sprite
const fps = 4
var time_since_last_frame = 0

onready var main = $"/root/Main"
onready var player = $"/root/Main/Player"
onready var aliens = $"/root/Main/Aliens"
onready var ammos = $"/root/Main/Ammos"

onready var graph = aliens.graph


func _ready():
	pass


func _process(delta):
	current_tile = get_tile(self)
	current_tile_time += delta
	path_cache_time -= delta
	if path_cache_time <= 0:
		if path and current_tile_time < tile_time_threshold:
			path = a_star_search(aliens.graph, path[0], get_tile(player))
		else:
			path = a_star_search(aliens.graph, current_tile, get_tile(player))
		path_cache_time = path_cache_duration
	if path.size() > 0:
		follow_path()
	
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
	if not is_on_floor():
		sprite.frame = 3
		time_since_last_frame = 0
	else:
		time_since_last_frame += delta
		if time_since_last_frame > 1.0 / fps:
			time_since_last_frame = 0
			if sprite.frame == 1:
				sprite.frame = 0
			else:
				sprite.frame = 1


func _physics_process(delta):
	velocity.y += gravity * delta
	if jump and is_on_floor():
		velocity.y = -jump_speed
	
	if move_right:
		velocity.x += speed
	if move_left:
		velocity.x -= speed
	if not move_right and not move_left:
		velocity.x += -speed * sign(velocity.x)
	
	velocity.x = clamp(velocity.x, -top_speed, top_speed)
	if velocity.y > top_fall_speed:
		velocity.y = top_fall_speed
	velocity = move_and_slide(velocity, Vector2(0, -1))


func follow_path():
	if current_tile == path[0] and is_on_floor():
		current_tile_time = 0
		path.pop_front()
	if path.size() > 0:
		move_towards(path[0])
	else:
		move_right = false
		move_left = false
		jump = false


func move_towards(tile):
	if tile.position.x > current_tile.position.x:
		move_right = true
		move_left = false
	else:
		move_right = false
		move_left = true
	jump = tile.position.y < current_tile.position.y
	for i in range(get_slide_count()):
		if get_slide_collision(i):
			if get_slide_collision(i).get_collider().get_parent() == aliens:
				jump = true
			if get_slide_collision(i).get_collider() == player:
				main.game_over()


func get_tile(node):
	var pos = node.position
	var candidates = []
	for t in graph.tiles:
		if t.position.y * graph.tile_size + graph.tile_size >= pos.y:
			if t.position.x * graph.tile_size <= pos.x and pos.x <= t.position.x * graph.tile_size + graph.tile_size:
				candidates.append(t)
	if candidates.size() == 0:
		var closest = graph.tiles[0]
		var min_length = (closest.position - pos).length_squared()
		for t in graph.tiles:
			var length = (t.position - pos).length_squared()
			if length < min_length:
				min_length = length
				closest = t
		return closest
	else:
		var closest = candidates[0]
		for c in candidates:
			if c.position.y - pos.y < closest.position.y - pos.y:
				closest = c
		return closest


func a_star_search(graph, start, goal):
	if not start or not goal:
		return []
	var frontier = PriorityQueue.new()
	frontier.append(start, 0)
	var came_from = {}
	var cost_so_far = {}
	came_from[start] = null
	cost_so_far[start] = 0
    
	while frontier.size() > 0:
		var current = frontier.pop_front()
        
		if current == goal:
			break
        
		for next in graph.neighbors(current):
			var new_cost = cost_so_far[current] + graph.cost(next)
			if not cost_so_far.keys().has(next) or new_cost < cost_so_far[next]:
				cost_so_far[next] = new_cost
				var priority = new_cost + heuristic(goal, next)
				frontier.append(next, priority)
				came_from[next] = current
	var path = [goal]
	var current = goal
	while current != start:
		path.append(came_from[current])
		current = came_from[current]
	path.append(start)
	path.invert()
	return path


func heuristic(a, b):
	return abs(a.position.x - b.position.x) + abs(a.position.y - b.position.y)


func on_kill():
	player.get_node("Hit").play()
	var chance = randi() % 2
	if chance == 1:
		var new = Ammo.instance()
		ammos.add_child(new)
		new.position = position
