extends Control

onready var background = $Background
const speed = Vector2(-100, -50)

func _process(delta):
	if abs(background.rect_position.x) > 1024:
		background.rect_position.x = 0
	if abs(background.rect_position.y) > 1024:
		background.rect_position.y = 0
	background.rect_position += speed * delta
	$CenterContainer.rect_size = get_viewport_rect().size


func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen


func _on_Quit_pressed():
	get_tree().quit()
