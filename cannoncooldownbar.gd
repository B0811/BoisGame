extends ProgressBar



func _process(delta):
	value = CurrencyManager.cannon_cooldown
	max_value = CurrencyManager.player_firerate
	
	#for future sound queues when bar is full
	if value >= max_value:
		pass
		
		
