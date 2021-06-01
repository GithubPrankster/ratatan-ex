extends Camera2D

var target_pos : Vector2 = position

func force_target(new_target : Vector2) -> void:
	target_pos = Vector2(160, 90)
	position = Vector2(160, 90)

func change_target(new_target : Vector2) -> void:
	target_pos = new_target

func _ready() -> void:
	Bus.connect("center_pos", self, "change_target")
	Bus.connect("force_pos", self, "force_target")

func _process(delta) -> void:
	if position != target_pos:
		position = lerp(position, target_pos, delta)
