extends Control

@onready var label_4 = $Label4

var time_elapsed = 0.0

func _ready():
	set_process(true) # Enable processing to update the timer

func _process(delta):
	time_elapsed += delta
	update_timer_label()

func update_timer_label():
	var minutes = int(time_elapsed / 60)
	var seconds = int(time_elapsed) % 60
	var time_string = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	label_4.text = time_string
