extends Node2D

var velocity : Vector2 = Vector2(-10, 0)
var spin : float = 2.0

func _ready() -> void:
	randomize()
	spin = rand_range(2.0, 8.0)

func _physics_process(delta) -> void:
	rotation += spin * delta
	translate(velocity * delta)
