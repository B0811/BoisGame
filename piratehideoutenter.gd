extends Area2D



func _on_area_entered(area):
	if area.is_in_group("players"):
		get_tree().change_scene_to_file("res://piratehideout.tscn")
