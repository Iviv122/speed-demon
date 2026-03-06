extends StaticBody2D
class_name Enemy 

@export var death_effect : PackedScene



func die() -> void:
	queue_free()