extends ProgressBar



func _process(delta):
	value = CurrencyManager.player_health
	max_value = CurrencyManager.player_max_health
