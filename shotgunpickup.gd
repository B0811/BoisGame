extends Node2D




func _on_pickuparea_area_entered(area):
	if area.is_in_group("players"):
		ShootingMechanics.basicshot = false
		ShootingMechanics.shotgunshot = true
		CurrencyManager.cannon_damage = CurrencyManager.cannon_damage * .25
		queue_free()
