extends Sprite

export(PackedScene) var scene_goto = null

onready var selector = $select

var normal_color : Color = modulate
var special_color : Color = Color(0.3, 0.6, 0.6, 0.8)

var original_y : float = 0.0
var rnd_offset : float = 0.0

# TODO: level logic (use an export var for the packed scene to enter!)
func _ready():
	randomize()
	rnd_offset = rand_range(0.0, 6.28)
	original_y = position.y

func _process(delta):
	position.y = original_y + (sin((OS.get_ticks_msec() * 0.001)+ rnd_offset) * 5.0)

func _on_area_mouse_entered():
	selector.play()
	modulate = special_color

func _on_area_mouse_exited():
	modulate = normal_color


func _on_area_input_event(viewport, event, shape_idx):
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
		print("swag")
