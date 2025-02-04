extends CharacterBody2D

var inrange = false

@onready var nav_agent_ = $NavigationAgent2D

@export var target_to_chase: CharacterBody2D

var timer = 0

var health = 5

var rng = RandomNumberGenerator.new()


const SPEED = 200.0

func _ready():
	rng.randomize()
	
func _physics_process(delta):
	if inrange == true:
		nav_agent_.target_position = target_to_chase.global_position
		velocity = global_position.direction_to(nav_agent_.get_next_path_position()) * SPEED
	
	
	
	move_and_slide()







func _on_area_2d_area_entered(area):
	if area.is_in_group("players") :
		inrange = true
		print("Player has been found")
		




func _on_area_2d_area_exited(area):
	if area.is_in_group("players"):
		velocity = Vector2.ZERO
		inrange = false
		print("player has been lost")


func _on_timer_timeout():
	if inrange == false and timer == 0:
			var random_number = randi()% 4
			match random_number:
				0: position.x += 10
				1: position.x -= 10
				2: position.y += 10
				3: position.y -= 10


func _on_hitboxarea_area_entered(area):
	if area.is_in_group("projectile"):
		health -= 1
		print("Hit! enemy health: " + str(health))
		death()

func death():
	if health <= 0:
		print("you did it!")
		CurrencyManager.moneys += rng.randi_range(5, 20)
		print(CurrencyManager.moneys)
		queue_free()
	elif health >= 0:
		pass
