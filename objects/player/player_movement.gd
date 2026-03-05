extends CharacterBody2D 
class_name CharacterMovement

@export var speed : float = 450 

var direction : Vector2 = Vector2(0,0)
var pressed : bool = false
var line : Line2D

func _ready():
	Engine.time_scale = 1

func _input(event):
	if event.is_action_pressed('m1'):
		pressed = true
		Engine.time_scale = 0.3

	if event.is_action_released("m1"):
		direction = (get_global_mouse_position() - global_position).normalized()
		pressed = false
		Engine.time_scale = 1


func die() -> void:
	Engine.time_scale = 1

func _physics_process(_delta: float) -> void:

	if direction == Vector2.ZERO:
		return

	velocity = direction*speed

	move_and_slide()