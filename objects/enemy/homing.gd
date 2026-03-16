extends Enemy
class_name HomingShooter

@export var target: Node2D
@export var shoot_time: float
@export var bullet: PackedScene


func on_ready() -> void:
	while true:
		await get_tree().create_timer(shoot_time).timeout
		shoot()

	
func shoot() -> void:
		shoot_bulet()

func shoot_bulet() -> void:
	if is_instance_valid(target):
		var b: Bullet = bullet.instantiate()
		b.global_position = global_position
		b.direction = (target.global_position - global_position).normalized()
		b.rotation = atan2(b.direction.y, b.direction.x)
		get_tree().current_scene.add_child(b)
