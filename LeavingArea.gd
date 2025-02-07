extends Area2D


func _on_area_entered(area):
	if area.is_in_group("hideoutship"):
		get_tree().change_scene_to_file("res://Scenes/node_2d.tscn")
		
