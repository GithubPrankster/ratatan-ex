extends Node2D

onready var intro : Node2D = $intro
onready var levels : Node2D = $levels
onready var fader : ColorRect = $fader

var letsgo : bool = false
var evil_fade : bool = false

func fade_it() -> void:
	evil_fade = true
	Bus.emit_signal("force_pos", fader.rect_global_position)

func _ready() -> void:
	fader.color.a = 1.0
	Bus.connect("fade_in", self, "fade_it")

func _unhandled_key_input(event) -> void:
	if event.is_pressed() and !letsgo:
		letsgo = true
		levels.visible = true
		levels.modulate.a = 0.0
		Music.target_db = 0.0
		fader.color.a = 0.0

func _process(delta) -> void:
	if letsgo:
		if intro.modulate.a != 0.0:
			intro.modulate.a = lerp(intro.modulate.a, 0.0, delta * 4)
		if levels.modulate.a != 1.0:
			levels.modulate.a = lerp(levels.modulate.a, 1.0, delta)
	if !evil_fade:
		if fader.color.a != 0.0:
			fader.color.a = lerp(fader.color.a, 0.0, delta * 2)
	else:
		if fader.color.a != 1.0:
			fader.color.a = clamp(fader.color.a + delta, 0.0, 1.0)
		else:
			Bus.emit_signal("faded")
			print("See ya")
			set_process(false) # buh bye
