extends Node2D

onready var stuff : Node2D = $match

func _ready() -> void:
	stuff.modulate.v = 0.0
	get_tree().paused = true
	VisualServer.set_shader_time_scale(0.0)

func _process(delta) -> void:
	if stuff.modulate.v != 1.0:
			stuff.modulate.v = clamp(stuff.modulate.v + (delta * 0.5), 0.0, 1.0)
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		if get_tree().paused:
			VisualServer.set_shader_time_scale(0.0)
		else:
			VisualServer.set_shader_time_scale(1.0)
