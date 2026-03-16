extends Area2D
class_name ExitPortal

@export var exit_effect : PackedScene

func _ready() -> void:
	body_entered.connect(check)

func check(body : Node2D) -> void:

	if body is CharacterMovement:
		win()
		print('won')

func win() -> void:
	var e : GPUParticles2D = exit_effect.instantiate()
	e.global_position = global_position
	e.restart()
	get_tree().current_scene.add_child(e)
