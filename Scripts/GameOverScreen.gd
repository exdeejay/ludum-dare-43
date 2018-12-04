extends CenterContainer

func _ready():
	$AudioStreamPlayer.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	rect_min_size = get_viewport_rect().size
	$ColorRect.rect_min_size = get_viewport_rect().size


func _on_Button_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
