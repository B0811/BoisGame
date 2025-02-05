extends Label


func _process(delta):
	text = "Enemies Sunk: " + str(CurrencyManager.enemies_sunk)
