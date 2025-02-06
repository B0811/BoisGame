extends Node

@onready var bootman = $"."

var moneys = 0

var player_firerate = 1.2

var global_player_position = 0

var current_wave: int

var moveing_to_next_wave: bool

var cannon_cooldown = 0

var enemies_sunk = 0
