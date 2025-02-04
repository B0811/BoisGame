extends Label

func _process(delta):
	self.text = str(CurrenyManager.moneys)
