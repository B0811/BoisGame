extends Node2D

@onready var sinking_enemy_sound = $SinkingEnemySound



func _on_sinking_enemy_sound_finished():
	queue_free()
