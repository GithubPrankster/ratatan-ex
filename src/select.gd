extends Node2D

onready var intro : Node2D = $intro
onready var levels : Node2D = $levels

var letsgo : bool = false

func _unhandled_key_input(event) -> void:
	if event.is_pressed() and !letsgo:
		letsgo = true
		levels.visible = true
		levels.modulate.a = 0.0
		Music.target_db = 0.0

func _process(delta) -> void:
	if letsgo:
		if intro.modulate.a != 0.0:
			intro.modulate.a = lerp(intro.modulate.a, 0.0, delta * 4)
		if levels.modulate.a != 1.0:
			levels.modulate.a = lerp(levels.modulate.a, 1.0, delta)
