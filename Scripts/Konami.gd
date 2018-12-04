extends Node2D

signal miss
signal done
signal step

const code = [KEY_UP, KEY_UP, KEY_DOWN, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_LEFT, KEY_RIGHT, KEY_B, KEY_A]
const threshold = 2
const skip_events = [
	InputEventMouseButton,
	InputEventMouseMotion,
	InputEventScreenTouch,
	InputEventScreenDrag,
	InputEventJoypadMotion
]
onready var timer = get_node("Timer")
var started = false
var command_index = 0

func _ready():
	if threshold > 0:
		timer.set_wait_time(threshold)
		timer.connect("timeout", self, "command_miss")
	set_process_input(true)

func _input(event):
	if event is InputEventKey:
		if not started and event.pressed and event.scancode == code[0]:
			started = true
			command_step()
		elif started:
			if event.pressed and event.scancode == code[command_index]:
				if command_index >= code.size() - 1:
					command_done()
				else:
					command_step()
			elif event.pressed:
				command_miss()

func command_done():
	if threshold > 0:
		timer.stop()
	reset_commands()
	emit_signal("done")

func command_step():
	command_index += 1
	if threshold > 0:
		timer.start()

func command_miss():
	if threshold > 0:
		timer.stop()
	reset_commands()

func reset_commands():
	command_index = 0
	started = false