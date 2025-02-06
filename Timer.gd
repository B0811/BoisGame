extends Timer

@onready var canvas_layer = $".."




func _on_timeout():
	canvas_layer.visible = true
	
	queue_free()
