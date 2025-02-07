extends CharacterBody2D

const SPEED = 300.0
@onready var bobbinganimation = $bobbinganimation
@onready var rockinganimation = $rockinganimation
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var camera_2d = $Camera2D



func _physics_process(_delta):
	
	
	# Omnidirectional movement
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector:
		velocity = input_vector * 300
	else:
		velocity = input_vector
	
	if velocity.x > 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = false
		

	move_and_slide()
	

		


