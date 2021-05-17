extends Node2D

onready var stuff = $match

func _ready():
	get_tree().paused = true
	VisualServer.set_shader_time_scale(0.0)

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		if get_tree().paused:
			VisualServer.set_shader_time_scale(0.0)
		else:
			VisualServer.set_shader_time_scale(1.0)
