extends Line2D
class_name LineClue

@export var player : CharacterMovement

var pressed: bool = false

func _ready():
	player.start.connect(start)
	player.ended.connect(ended)


func start() -> void:
	pressed = true

func ended() -> void:
	pressed = false


func _process(_delta):
	if pressed:
		points[0] = to_local(player.global_position)
		points[1] = get_local_mouse_position()
	else:
		points[0] = Vector2.ZERO
		points[1] = Vector2.ZERO
