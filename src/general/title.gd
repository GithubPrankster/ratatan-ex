extends Sprite

var original_y : float = 0.0

func _ready() -> void:
	original_y = position.y

func _process(_delta) -> void:
	position.y = original_y + (sin(OS.get_ticks_msec() * 0.001) * 7.0)
