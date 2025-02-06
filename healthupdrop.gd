extends Node2D


func _on_pickuparea_area_entered(area):
	if area.is_in_group("players"):
		queue_free()
