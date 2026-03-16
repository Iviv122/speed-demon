extends Area2D
class_name Bullet

@export var speed: float = 350
@export var direction: Vector2 = Vector2.RIGHT

func _ready():
	body_entered.connect(die)

func die(body: Node2D):
	if body is CharacterMovement:
		body.die()

	if body is Enemy || body is Bullet:
		return

	queue_free()

func _process(delta: float) -> void:
	global_position += direction * delta * speed
