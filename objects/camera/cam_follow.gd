extends Camera2D
class_name CamFollow

@export var target : Node2D

func _process(delta):
	if is_instance_valid(target):
		global_position = target.global_position
