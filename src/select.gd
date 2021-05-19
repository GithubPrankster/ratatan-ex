extends Node2D

onready var respite : AudioStreamPlayer = $respite
onready var intro : Node2D = $intro
onready var levels : Node2D = $levels

var letsgo : bool = false
var vol_target :float = -20.0

func _unhandled_key_input(event) -> void:
	if event.is_pressed() and !letsgo:
		letsgo = true
		levels.visible = true
		levels.modulate.a = 0.0
		vol_target = 0.0

func _process(delta) -> void:
	if respite.volume_db != vol_target:
		respite.volume_db = lerp(respite.volume_db, vol_target, delta)
	if letsgo:
		if intro.modulate.a != 0.0:
			intro.modulate.a = lerp(intro.modulate.a, 0.0, delta * 4)
		if levels.modulate.a != 1.0:
			levels.modulate.a = lerp(levels.modulate.a, 1.0, delta)
