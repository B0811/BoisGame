extends Area2D

@onready var control_2 = $"../Control2"



func _on_area_entered(area):
	if area.is_in_group("players"):
		control_2.visible = true
