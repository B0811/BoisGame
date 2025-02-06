extends Timer

@onready var animation_player = $"../AnimationPlayer"


func _on_timeout():
	animation_player.autoplay
