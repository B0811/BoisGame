extends AnimationPlayer

@onready var color_rect = $".."
# Called when the node enters the scene tree for the first time.



func _on_animation_finished(fadein):
	queue_free()
	print("done")

