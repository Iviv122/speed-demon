extends Camera2D
class_name CamFollow

@export var target : Node2D

func _process(delta):
    global_position = target.global_position