extends Node2D

@export var enemyboot_scene: PackedScene

var current_wave: int

var starting_nodes: int
var current_nodes: int

var wave_spawn_ended

func _ready():
	current_wave = 0
	CurrencyManager.current_wave = current_wave
	starting_nodes = get_child_count()
	current_nodes = get_child_count()
	position_to_next_wave()

func position_to_next_wave():
	if current_nodes == starting_nodes:
		if current_wave != 0: 
			CurrencyManager.moving_to_next_wave = true
		wave_spawn_ended = false
		current_wave += 1
		CurrencyManager.current_wave = current_wave
		await get_tree().create_timer(0.5).timeout
		prepare_spawn("enemyboot", 4.0, 4.0) #type, multiplier, mob spawns

func prepare_spawn(type, multiplier, mob_spawns):
	var mob_amount = float(current_wave) * multiplier
	var mob_wait_time: float = 2
	print("mob_amount: ", mob_amount)
	var mob_spawn_rounds = mob_amount/mob_spawns
	spawn_type(type, mob_spawn_rounds, mob_wait_time)
	

func spawn_type(type, mob_spawn_rounds, mob_wait_time):
	if type == "enemyboot":
		var boot_spawn1 = $bootspawn1
		var boot_spawn2 = $bootspawn2
		var boot_spawn3 = $bootspawn3
		var boot_spawn4 = $bootspawn4
		var boot_spawn5 = $bootspawn5
		if mob_spawn_rounds >= 1:
			for i in mob_spawn_rounds:
				var enemyboot1 = enemyboot_scene.instantiate()
				enemyboot1.global_position = boot_spawn1.global_position
				var enemyboot2 = enemyboot_scene.instantiate()
				enemyboot2.global_position = boot_spawn2.global_position
				var enemyboot3 = enemyboot_scene.instantiate()
				enemyboot3.global_position = boot_spawn3.global_position
				var enemyboot4 = enemyboot_scene.instantiate()
				enemyboot4.global_position = boot_spawn4.global_position
				#var enemyboot5 = enemyboot_scene.instantiate()
				#enemyboot5.global_position = boot_spawn5.global_position
				add_child(enemyboot1)
				add_child(enemyboot2)
				add_child(enemyboot3)
				add_child(enemyboot4)
				#add_child(enemyboot5)
				mob_spawn_rounds -= 1
				await get_tree().create_timer(mob_wait_time).timeout
		wave_spawn_ended = true

func _process(delta):
	current_nodes = get_child_count()
	if wave_spawn_ended:
		position_to_next_wave()
