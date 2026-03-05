extends Label
class_name FPScounter

func _process(delta : float):
	text = str(1.0/delta)
