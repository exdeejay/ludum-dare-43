extends MarginContainer

onready var player = $"/root/Main/Player"
onready var o2_val = $"HBoxContainer/HBoxContainer/Values/O2"
onready var energy_val = $"HBoxContainer/HBoxContainer/Values/Energy"


func _process(delta):
	var left = ceil(player.o2)
	var minutes = abs(floor(left / 60))
	var seconds = int(left) % 60
	o2_val.text = str(minutes) + ":" + "%02d" % seconds
	energy_val.text = str(player.energy)
