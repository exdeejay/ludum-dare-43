extends Node2D

const Crosshairs = preload("res://Scenes/Crosshairs.tscn")
const PauseScreen = preload("res://Scenes/PauseScreen.tscn")
const GameOverScreen = preload("res://Scenes/GameOverScreen.tscn")
onready var crosshairs = Crosshairs.instance()


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$CanvasLayer.add_child(crosshairs)


func _process(delta):
	crosshairs.position = get_viewport().get_mouse_position()
	if Input.is_action_just_pressed("ui_pause"):
		pause()


func pause():
	get_tree().paused = true
	$CanvasLayer.add_child(PauseScreen.instance())


func game_over():
	get_tree().paused = true
	$CanvasLayer.add_child(GameOverScreen.instance())
