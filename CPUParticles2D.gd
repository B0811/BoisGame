extends CPUParticles2D


func _ready():
	emitting = true




func _on_toolong_timeout():
	queue_free()
