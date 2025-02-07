extends Label

func _process(delta):
	text = "Cannonball Damage: " + str(CurrencyManager.cannon_damage)
