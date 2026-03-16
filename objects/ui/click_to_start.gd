extends Node

@export var scene : String

func _input(event):
    if event.is_action_pressed('m1'):
        get_tree().change_scene_to_file(scene)