extends CenterContainer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	rect_min_size = get_viewport_rect().size
	$ColorRect.rect_min_size = get_viewport_rect().size


func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		get_tree().paused = false
		queue_free()
