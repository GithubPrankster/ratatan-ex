extends Sprite

var og_pos_y : float = position.y
var floatin : bool = true
var liftoff : Vector2 = Vector2(1, 0)

onready var death_note : Timer = $death
var acc : float = 0.0

func _physics_process(delta):
	if floatin:
		position.y = og_pos_y + sin(acc * 4) * 5.0
	else:
		position -= liftoff * 128.0 * delta
		rotation += 8.0 * delta
	acc += delta

func _on_area_area_entered(area : Area2D):
	if area.name != "funni":
		floatin = false
		liftoff = (area.global_position - global_position).normalized()
		death_note.start()

func _on_death_timeout():
	queue_free()
