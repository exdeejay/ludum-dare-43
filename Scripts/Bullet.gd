extends Area2D

onready var aliens = $"/root/Main/Aliens"

const speed = 100
const threshold = 1000 * 64
var direction = Vector2()
var last_pos

func _ready():
	last_pos = position

func _process(delta):
	position += direction * speed
	for a in aliens.get_children():
		if line_intersects_rect(last_pos, position, a.position, a.get_child(1).shape.extents):
			a.on_kill()
			a.queue_free()
			queue_free()
	if abs(position.x) > threshold or abs(position.y) > threshold:
		queue_free()
	last_pos = position

func line_intersects_rect(p1, p2, pos, extents):
	if line_intersects_line(p1, p2, Vector2(pos.x - extents.x, pos.y - extents.y), Vector2(pos.x + extents.x, pos.y - extents.y)):
		return true
	if line_intersects_line(p1, p2, Vector2(pos.x - extents.x, pos.y - extents.y), Vector2(pos.x - extents.x, pos.y + extents.y)):
		return true
	if line_intersects_line(p1, p2, Vector2(pos.x + extents.x, pos.y - extents.y), Vector2(pos.x + extents.x, pos.y + extents.y)):
		return true
	if line_intersects_line(p1, p2, Vector2(pos.x - extents.x, pos.y + extents.y), Vector2(pos.x + extents.x, pos.y + extents.y)):
		return true
	if pos.x - extents.x < p1.x and p1.x < pos.x + extents.x:
		if pos.y - extents.y < p1.y and p1.y < pos.y + extents.y:
			if pos.x - extents.x < p2.x and p2.x < pos.x + extents.x:
				if pos.y - extents.y < p2.y and p2.y < pos.y + extents.y:
					return true
	return false

func line_intersects_line(l1p1, l1p2, l2p1, l2p2):
	var q = (l1p1.y - l2p1.y) * (l2p2.x - l2p1.x) - (l1p1.x - l2p1.x) * (l2p2.y - l2p1.y)
	var d = (l1p2.x - l1p1.x) * (l2p2.y - l2p1.y) - (l1p2.y - l1p1.y) * (l2p2.x - l2p1.x)

	if d == 0:
		return false

	var r = q / d

	q = (l1p1.y - l2p1.y) * (l1p2.x - l1p1.x) - (l1p1.x - l2p1.x) * (l1p2.y - l1p1.y)
	var s = q / d

	if r < 0 or r > 1 or s < 0 or s > 1:
		return false

	return true
