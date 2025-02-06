extends Node2D

@onready var sprite_2d = $Sprite2D

var direction = Vector2(1,0)

var boolit_speed = 500

func _physics_process(delta):
	position += direction * boolit_speed * delta
	sprite_2d.rotation += -5 * delta




	


func _on_area_2d_area_entered(area):
	if area.is_in_group("players"):	
		queue_free()
		print("BOOM")


func _on_toolong_timeout():
	queue_free()
