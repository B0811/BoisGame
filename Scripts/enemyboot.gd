extends CharacterBody2D

var inrange = false
@onready var shoottimer = $shoottimer

@onready var player = get_tree().get_nodes_in_group("players")

@onready var bootman = $"."

const CANNONPARTICLES = preload("res://cannonparticles.tscn")

var cannonball_scene = preload("res://enemycanonbaw.tscn")

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
		_on_shoottimer_timeout()


func enemyshoot():
	if inrange == true:
		var cannonball_scene = cannonball_scene.instantiate()
		var ship_position = global_position # Use global_position to get the ship's current position
		var cannon_offset = Vector2(0, 40) # Offset the origin by 40 pixels down
		var cannon_position = ship_position + cannon_offset # Calculate the cannon's origin position
		cannonball_scene.position = cannon_position
		cannonball_scene.direction = (CurrencyManager.global_player_position - cannon_position).normalized() # Use the offset position for direction calculation
	
		get_parent().add_child(cannonball_scene)
	
	
		spawn_muzzle_flash(cannon_position) # Spawn the muzzle flash effect


func spawn_muzzle_flash(position):
	var muzzle_flash = CANNONPARTICLES.instantiate()
	muzzle_flash.position = position
	muzzle_flash.rotation = (get_global_mouse_position() - position).angle() # Set the rotation based on the mouse direction
	get_parent().add_child(muzzle_flash)


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


func _on_shoottimer_timeout():
	enemyshoot()
	shoottimer.start()
