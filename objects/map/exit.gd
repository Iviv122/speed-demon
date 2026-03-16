extends Area2D
class_name ExitPortal

@export var exit_effect: PackedScene
@export var scene_to_load: String

func _ready() -> void:
	body_entered.connect(check)

func check(body: Node2D) -> void:
	Engine.time_scale = 1
	if body is CharacterMovement:
		body.can_die = false
		var t: Tween = create_tween()

		t.tween_property(body, "global_position", global_position, 0.2)
		t.tween_property(body, "scale", Vector2(0, 0), 0.2)
		Engine.time_scale = 1
		await get_tree().create_timer(0.2).timeout
		Engine.time_scale = 1
		body.queue_free()
		win()
		get_tree().change_scene_to_file(scene_to_load)

func win() -> void:
	var e: GPUParticles2D = exit_effect.instantiate()
	e.global_position = global_position
	e.restart()
	get_tree().current_scene.add_child(e)
