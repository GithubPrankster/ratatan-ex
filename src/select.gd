extends Node2D

onready var intro : Node2D = $intro
onready var levels : Node2D = $levels

var letsgo : bool = false
var evil_fade : bool = false

func fade_it() -> void:
	evil_fade = true

func _ready() -> void:
	modulate.v = 0.0
	Bus.connect("fade_in", self, "fade_it")

func _unhandled_key_input(event) -> void:
	if event.is_pressed() and !letsgo:
		letsgo = true
		levels.visible = true
		levels.modulate.a = 0.0
		Music.target_db = 0.0

func _process(delta) -> void:
	if letsgo:
		if intro.modulate.a != 0.0:
			intro.modulate.a = clamp(intro.modulate.a - (delta * 3), 0.0, 1.0)
		if levels.modulate.a != 1.0:
			levels.modulate.a = clamp(levels.modulate.a + delta, 0.0, 1.0)
	if !evil_fade:
		if modulate.v != 1.0:
			modulate.v = clamp(modulate.v + delta, 0.0, 1.0)
	else:
		if modulate.v != 0.0:
			modulate.v = clamp(modulate.v - (delta * 0.5), 0.0, 1.0)
		else:
			Bus.emit_signal("faded")
			print("See ya")
			set_process(false) # buh bye
