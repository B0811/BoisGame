extends Node
@onready var cannon_sound = $CannonSound

var basicshot = true

@onready var mouse = 0

const CANNONPARTICLES = preload("res://cannonparticles.tscn")
var cannonball_scene = preload("res://canonbaw.tscn")
var last_shot = 0.0
const SPEED = 300.0
var shot_cooldown = 0.5

func basic_shot():
	var cannonball_scene = cannonball_scene.instantiate()
	var ship_position = CurrencyManager.global_player_position # Use global_position to get the ship's current position
	var cannon_offset = Vector2(0, 40) # Offset the origin by 40 pixels down
	var cannon_position = ship_position + cannon_offset # Calculate the cannon's origin position
	cannonball_scene.position = cannon_position
	cannonball_scene.direction = (mouse - cannon_position).normalized() # Use the offset position for direction calculation
	
	get_parent().add_child(cannonball_scene)
	
	var random_number = randf_range(.8, 1.1)
	
	cannon_sound.play()
	cannon_sound.pitch_scale = random_number
	
	
	
	spawn_muzzle_flash(cannon_position) # Spawn the muzzle flash effect


func spawn_muzzle_flash(position):
	var muzzle_flash = CANNONPARTICLES.instantiate()
	muzzle_flash.position = position
	muzzle_flash.rotation = (mouse - position).angle() # Set the rotation based on the mouse direction
	get_parent().add_child(muzzle_flash)
