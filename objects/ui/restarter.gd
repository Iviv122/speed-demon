extends Node2D
class_name Restarter

@export var move_time : float
@export var player : CharacterMovement

var r : bool = false

func _ready():

	player.died.connect(shoot)
	visible = false
	global_position.y -= 10000



func shoot() -> void:
	visible = true 

	var tween := create_tween()
	tween.tween_property(self,'global_position',player.global_position,move_time)
	await get_tree().create_timer(move_time).timeout
	r = true

func restart() -> void:
	get_tree().reload_current_scene()

func _input(event) -> void:
	if event.is_action_pressed('m1') && r:
		restart()
