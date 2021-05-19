extends Camera2D

var target_pos : Vector2 = position

func change_target(new_target : Vector2) -> void:
	target_pos = new_target

func _ready():
	Bus.connect("center_pos", self, "change_target")

func _process(delta):
	if position != target_pos:
		position = lerp(position, target_pos, delta)
