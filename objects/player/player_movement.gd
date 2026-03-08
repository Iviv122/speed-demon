extends CharacterBody2D
class_name CharacterMovement

@export var speed: float = 450
@export var player_radius: float = 63
@export var collide_effect: PackedScene
@export var camera: Camera2D
@export var bump_maker: AudioStreamPlayer

@export var cam_zoom: Vector2
@export var speed_cam_zoom: Vector2
@export var zoom_speed: float = 0.4

signal died()

signal start()
signal ended()

var direction: Vector2 = Vector2(0, 0)
var pressed: bool = false

var t: Tween

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
	if t:
		t.kill()

	t = get_tree().create_tween()
	t.tween_property(camera, "zoom", speed_cam_zoom, zoom_speed).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)

	start.emit()
	Engine.time_scale = 0.3

func turn_off() -> void:
	if t:
		t.kill()

	t = get_tree().create_tween()
	t.tween_property(camera, "zoom", cam_zoom, zoom_speed).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)


	ended.emit()
	Engine.time_scale = 1

func is_collide() -> void:
	var space_state = get_world_2d().direct_space_state
	
	var ray_length = player_radius * 1.1
	var dir = direction.normalized()

	var perp = Vector2(-dir.y, dir.x)

	var query = PhysicsRayQueryParameters2D.create(
		global_position,
		global_position + dir * ray_length
	)
	query.exclude = [ self ]

	var query_left = PhysicsRayQueryParameters2D.create(
		global_position + perp * player_radius,
		global_position + perp * player_radius + dir * ray_length
	)
	query_left.exclude = [ self ]

	var query_right = PhysicsRayQueryParameters2D.create(
		global_position - perp * player_radius,
		global_position - perp * player_radius + dir * ray_length
	)
	query_right.exclude = [ self ]

	var result = space_state.intersect_ray(query)
	var result_left = space_state.intersect_ray(query_left)
	var result_right = space_state.intersect_ray(query_right)

	if result:
		bounce(result.normal,result.collider,result.position)
	elif result_left:
		bounce(result_left.normal,result_left.collider,result_left.position)
	elif result_right:
		bounce(result_right.normal,result_right.collider,result_right.position)

func bounce(normal: Vector2,collider: Node2D, pos : Vector2) -> void:
	direction = direction.bounce(normal)

	if collider is Enemy:
		collider.die()

	bump_maker.play()
	spawn_effect(pos)

func spawn_effect(pos: Vector2) -> void:
	var ef: OneshotEffect = collide_effect.instantiate()

	ef.restart()
	ef.global_position = pos

	get_tree().current_scene.add_child(ef)


func _physics_process(_delta: float) -> void:
	if direction == Vector2.ZERO:
		return


	is_collide()
	velocity = direction * speed
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
