extends StaticBody2D
class_name Enemy 

@export var death_effect : PackedScene



func die() -> void:
	var e : OneshotEffect = death_effect.instantiate()
	e.global_position = global_position
	e.restart()

	get_tree().current_scene.add_child(e)
	AudioManagerInstance.enemy_death_sound.play()
	queue_free()
