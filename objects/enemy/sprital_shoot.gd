extends Enemy
class_name SpiralShooter

@export var shoot_time: float
@export var bullet: PackedScene
@export var start_rot: float = 0 
@export var rot: float = 15

var dir = Vector2.LEFT

func on_ready() -> void:
	dir = dir.rotated(start_rot)
	while true:
		await get_tree().create_timer(shoot_time).timeout
		shoot()
		dir = dir.rotated(rot)

	
func shoot() -> void:
		shoot_bulet()

func shoot_bulet() -> void:
	var b: Bullet = bullet.instantiate()
	b.global_position = global_position + dir*128
	b.direction = dir
	b.rotation = atan2(dir.y, dir.x)
	get_tree().current_scene.add_child(b)