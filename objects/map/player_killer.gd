extends Area2D
class_name PlayerKiller 

func _ready() -> void:
	body_entered.connect(kill)

func kill(body : Node2D) -> void:
	if body is CharacterMovement:
		body.die()
