extends Node2D
@onready var sprite_2d = $Sprite2D

var direction = Vector2(1,0)

var boolit_speed = 500

func _physics_process(delta):
	position += direction * boolit_speed * delta
	sprite_2d.rotation += -5 * delta
