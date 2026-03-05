extends CharacterBody2D 
class_name CharacterMovement

@export var speed : float = 450 
@export var player_radius : float = 63


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
		global_rotation = atan2(direction.y,direction.x)
		pressed = false
		Engine.time_scale = 1


func die() -> void:
	Engine.time_scale = 1

func is_collide() -> void:
	var space_state = get_world_2d().direct_space_state
	
	var ray_length = player_radius
	var dir = direction.normalized()

	# perpendicular vector
	var perp = Vector2(-dir.y, dir.x)

	var query = PhysicsRayQueryParameters2D.create(
		global_position,
		global_position + dir * ray_length
	)
	query.exclude = [self]

	var query_left = PhysicsRayQueryParameters2D.create(
		global_position + perp * player_radius,
		global_position + perp * player_radius + dir * ray_length
	)
	query_left.exclude = [self]

	var query_right = PhysicsRayQueryParameters2D.create(
		global_position - perp * player_radius,
		global_position - perp * player_radius + dir * ray_length
	)
	query_right.exclude = [self]

	var result = space_state.intersect_ray(query)
	var result_left = space_state.intersect_ray(query_left)
	var result_right = space_state.intersect_ray(query_right)

	if result:
		direction = direction.bounce(result.normal)
	elif result_left:
		direction = direction.bounce(result_left.normal)
	elif result_right:
		direction = direction.bounce(result_right.normal)

func _physics_process(_delta: float) -> void:

	if direction == Vector2.ZERO:
		return

	is_collide()

	velocity = direction*speed
	move_and_slide()
		
