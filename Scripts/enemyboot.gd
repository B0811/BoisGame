extends CharacterBody2D

var inrange = false
@onready var shoottimer = $shoottimer
@onready var sprite_2d = $Sprite2D
const SINKINGSHIPSOUND = preload("res://sinkingenemyship.tscn")
@onready var player = get_tree().get_nodes_in_group("players")

var health_up = preload("res://healthupdrop.tscn")

@onready var start_position = global_position
@onready var target_pos = global_position

@onready var wander_range = 200

@onready var timer = $Timer

@onready var bootman = $"."

@onready var navtimer = $navtimer

var dropchance = 0

const CANNONPARTICLES = preload("res://cannonparticles.tscn")

var cannonball_scene = preload("res://enemycanonbaw.tscn")

@onready var nav_agent_ = $NavigationAgent2D

@export var target_to_chase: CharacterBody2D

var playerradiuscheck = false

var health = 5

var rng = RandomNumberGenerator.new()

const wanderspeed = 100.0
const SPEED = 200.0
const renav = 150

func _ready():
	rng.randomize()


func _physics_process(delta):
	if playerradiuscheck == true and navtimer.time_left == 0:
		_on_navtimer_timeout()
	elif playerradiuscheck == false:
		if inrange == true:
			nav_agent_.target_desired_distance = 500
			nav_agent_.target_position = CurrencyManager.global_player_position 
			velocity = global_position.direction_to(nav_agent_.get_next_path_position()) * SPEED
	
		
	if velocity.x > 0:
		sprite_2d.flip_h = true
	elif velocity.x < 0:
		sprite_2d.flip_h = false
	
	move_and_slide()







func _on_area_2d_area_entered(area):
	if area.is_in_group("players") :
		inrange = true
		#print("Player has been found")
		_on_shoottimer_timeout()


func enemyshoot():
	if inrange == true:
		var cannonball_scene = cannonball_scene.instantiate()
		var ship_position = global_position # Use global_position to get the ship's current position
		var cannon_offset = Vector2(0, 40) # Offset the origin by 40 pixels down
		var cannon_position = ship_position + cannon_offset # Calculate the cannon's origin position
		cannonball_scene.position = cannon_position
		cannonball_scene.direction = (CurrencyManager.global_player_position + Vector2(randi_range(-60, 60), randi_range(-60, 60)) - cannon_position).normalized() # Use the offset position for direction calculation
	
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
		start_position = global_position
		#print("player has been lost")

func update_target_position():
	var target_vector = Vector2(randf_range(-wander_range, wander_range), randf_range(-wander_range, wander_range))
	nav_agent_.target_position = start_position + target_vector
	velocity = global_position.direction_to(nav_agent_.get_next_path_position()) * wanderspeed

func start_timer(duration):
	timer.start(duration)

func _on_timer_timeout():
	if inrange == false:
		#print("times up")
		update_target_position()
		#print(update_target_position())


func _on_hitboxarea_area_entered(area):
	if area.is_in_group("projectile"):
		health -= CurrencyManager.cannon_damage
		#print("Hit! enemy health: " + str(health))
		death()

func death():
	var health_up_drop = health_up.instantiate()
	health_up_drop.position = global_position
	if health <= 0:
		var sinking_ship_sound = SINKINGSHIPSOUND.instantiate()
		get_parent().add_child(sinking_ship_sound)
		#print("you did it!")
		CurrencyManager.moneys += rng.randi_range(5, 20)
		#print(CurrencyManager.moneys)
		CurrencyManager.enemies_sunk += 1
		dropchance = rng.randi_range(0, 100)
		if dropchance <= 25:
			get_parent().add_child(health_up_drop)
		elif dropchance >= 26:
			pass
		queue_free()
	elif health >= 0:
		pass
	
	

func _on_shoottimer_timeout():
	enemyshoot()
	shoottimer.start()



func _on_radius_area_entered(area):
	if area.is_in_group("playercircle"):
		playerradiuscheck = true


func _on_radius_area_exited(area):
	if area.is_in_group("playercircle"):
		playerradiuscheck = false





func _on_navtimer_timeout():
	nav_agent_.target_position = CurrencyManager.global_player_position - Vector2(randi_range(-100, 100), randi_range(-100, 100))
	#velocity = Vector2.ZERO
	velocity = global_position.direction_to(nav_agent_.get_next_path_position()) * renav
	navtimer.start()
