extends CharacterBody2D 
class_name CharacterMovement

@export var speed : float = 450 
@export var player_radius : float = 63


signal died()

signal start()
signal ended()

var direction : Vector2 = Vector2(0,0)
var pressed : bool = false

func _ready():
	Engine.time_scale = 1

func _input(event):

	if event.is_action_pressed('m1') && !pressed:
		pressed = true
		turn_on()	

	if event.is_action_released("m1") && pressed:
		redirect()
		turn_off()
		pressed = false


func redirect() -> void:
	direction = (get_global_mouse_position() - global_position).normalized()

func die() -> void:
	died.emit()

func turn_on() -> void:
	start.emit()
	Engine.time_scale = 0.3

func turn_off() -> void:
	ended.emit()
	Engine.time_scale = 1

func is_collide() -> void:
	var space_state = get_world_2d().direct_space_state
	
	var ray_length = player_radius*1.1
	var dir = direction.normalized()

	var perp = Vector2(-dir.y, dir.x)

	var query = PhysicsRayQueryParameters2D.create(
		global_position,
		global_position + dir * ray_length 
	)

	var query_left = PhysicsRayQueryParameters2D.create(
		global_position + perp * player_radius,
		global_position + perp * player_radius + dir * ray_length
	)

	var query_right = PhysicsRayQueryParameters2D.create(
		global_position - perp * player_radius,
		global_position - perp * player_radius + dir * ray_length
	)

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
		
#func _draw():
#	var ray_length = player_radius*1.1
#	var dir = direction.normalized()

#	var perp = Vector2(-dir.y, dir.x)

#	draw_line(
#		Vector2.ZERO,
#		dir * ray_length,
#		Color.RED
#	)
#	draw_line(
#		Vector2.ZERO + perp * player_radius,
#		Vector2.ZERO + perp * player_radius + dir * ray_length,
#		Color.BLACK
#	)
#	draw_line(
#		Vector2.ZERO - perp * player_radius,
#		Vector2.ZERO - perp * player_radius + dir * ray_length,
#		Color.PURPLE
#	)
