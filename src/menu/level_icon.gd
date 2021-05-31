extends Sprite

export(String, FILE, "*.tscn") var scene_goto : String = String()

onready var selector : AudioStreamPlayer = $select

var normal_color : Color = modulate
var special_color : Color = Color(0.3, 0.6, 0.6, 0.8)

var original_y : float = 0.0
var rnd_offset : float = 0.0

func _ready() -> void:
	randomize()
	rnd_offset = rand_range(0.0, 6.28)
	original_y = position.y

func _process(_delta) -> void:
	position.y = original_y + (sin((OS.get_ticks_msec() * 0.001)+ rnd_offset) * 5.0)

func _on_area_mouse_entered() -> void:
	selector.play()
	modulate = special_color
	Bus.emit_signal("center_pos", position)

func _on_area_mouse_exited() -> void:
	modulate = normal_color

func _on_area_input_event(_viewport, event, _shape_idx) -> void:
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
		SceneLoader.load_scene(scene_goto)
