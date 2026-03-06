extends GPUParticles2D
class_name OneshotEffect

func _ready() -> void:

	restart()
	await get_tree().create_timer(lifetime).timeout
	queue_free()