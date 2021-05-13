extends Sprite

export(float, 0.0, 0.5) var mov : float = 0.25
export(float) var grav : float = 0.1
export(float) var power : float = grav + 0.2

var velocity : Vector2 = Vector2(mov, 0.0)
var pause : bool = true
var finish : bool = false

func _physics_process(delta):
	if Input.is_action_just_pressed("pause"):
		pause = !pause
	if !pause and !finish:
		if Input.is_action_pressed("propel"):
			velocity.y -= power
		
		velocity.y += grav
		translate(velocity)

func _on_area_area_entered(area):
	if area.name != "funni":
		velocity = Vector2.ZERO
		finish = true

func _on_area_area_exited(area):
	if area.name == "funni":
		velocity = Vector2.ZERO
		finish = true
