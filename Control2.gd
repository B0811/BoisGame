extends Control



@onready var button = $ColorRect/Button
@onready var button_2 = $ColorRect/Button2
@onready var button_3 = $ColorRect/Button3
@onready var button_4 = $ColorRect/Button4



func _on_shoparea_area_entered(area):
	
	if area.is_in_group("hideoutship"):
		visible = true
		button.disabled = false
		
		button_2.disabled = false
		
		button_4.disabled = false
		
		button_3.disabled = false
		
		
func _on_shoparea_area_exited(area):
	if area.is_in_group("hideoutship"):
		visible = false
		button.disabled = true
		
		button_2.disabled = true
		
		button_4.disabled = true

		button_3.disabled = true


func _on_button_pressed():
	if CurrencyManager.moneys >= 50:
		CurrencyManager.player_firerate *= .9
		print("Increased reload speed to ", CurrencyManager.player_firerate)
		CurrencyManager.moneys -= 50



func _on_button_2_pressed():
	if CurrencyManager.moneys >= 50:
		if ShootingMechanics.basicshot == true:
			CurrencyManager.cannon_damage += .5
			print("Increased cannon damage to ", CurrencyManager.cannon_damage)
			CurrencyManager.moneys -= 50
		elif ShootingMechanics.shotgunshot == true:
			CurrencyManager.cannon_damage += .10
			print("Increased cannon damage to ", CurrencyManager.cannon_damage)
			CurrencyManager.moneys -= 50


func _on_button_3_pressed():
	if CurrencyManager.moneys >= 50:
		CurrencyManager.player_max_health += 1
		print("Increased hull strength (Max HP) to ", CurrencyManager.player_max_health)
		CurrencyManager.moneys -= 50
	


func _on_button_4_pressed():
	if CurrencyManager.moneys >= 50:
		CurrencyManager.player_health = CurrencyManager.player_max_health
		print("Repaired hull to ", CurrencyManager.player_max_health)
		CurrencyManager.moneys -= 50
