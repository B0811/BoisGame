extends CharacterBody2D

var inrange = false

@onready var nav_agent_ = $NavigationAgent2D

@export var target_to_chase: CharacterBody2D

const SPEED = 200.0

func _physics_process(delta):
	if inrange == true:
		nav_agent_.target_position = target_to_chase.global_position
		velocity = global_position.direction_to(nav_agent_.get_next_path_position()) * SPEED
		
	
	move_and_slide()







func _on_area_2d_area_entered(area):
	if area.is_in_group("players") :
		inrange = true
		print("Player has been found")
