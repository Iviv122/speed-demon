extends Enemy
class_name CrossShooter

@export var shoot_time : float
@export var bullet : PackedScene

var dirs = [Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT,Vector2.UP]

func on_ready() -> void:


	while true:
		await get_tree().create_timer(shoot_time).timeout
		shoot()

	

func shoot() -> void:

	for i in dirs:
		
		pass	

func shoot_bulet() -> void:
	pass