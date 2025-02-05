extends Area2D



func _on_area_entered(area):
	if area.is_in_group("players"):
		print("Entering Hideout...")
		get_tree().change_scene_to_file("res://hideoutinside.tscn")
