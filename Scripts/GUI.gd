extends MarginContainer

onready var player = $"/root/Main/Player"
onready var o2_val = $"HBoxContainer/HBoxContainer/Values/O2"
onready var energy_val = $"HBoxContainer/HBoxContainer/Values/Energy"
var last_second

func _process(delta):
	var left = ceil(player.o2)
	var minutes = abs(floor(left / 60))
	var seconds = int(left) % 60
	o2_val.text = str(minutes) + ":" + "%02d" % seconds
	if player.o2 < 10:
		if last_second != seconds:
			last_second = seconds
			player.get_node("Warning").play()
		o2_val.set("custom_colors/font_color", ColorN("red") if seconds % 2 == 0 else ColorN("white"))
	else:
		o2_val.set("custom_colors/font_color", ColorN("white"))
	
	energy_val.text = str(player.energy)
