extends Node

var load_screen : PackedScene = preload("res://src/general/loading.tscn")

var root = null
var current_scene = null

var loader : ResourceInteractiveLoader = null
var time_max = 100 # msec
var blocker : bool = false

func _ready() -> void:
	root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func _process(delta) -> void:
	if loader == null:
		set_process(false)
		return

	while OS.get_ticks_msec() < OS.get_ticks_msec() + time_max:
		var err = loader.poll()

		if err == ERR_FILE_EOF: # Finish!
			current_scene.queue_free()
			current_scene = loader.get_resource().instance()
			loader = null
			
			root.add_child(current_scene)
			Music.target_db = 0.0
			break
		elif err != OK:
			print("WOW. Couldn't even load it?!")
			loader = null
			break

func load_scene(path : String) -> void:
	blocker = true
	
	Music.target_db = -80.0
	Bus.emit_signal("fade_in")
	yield(Bus, "faded")
	
	loader = ResourceLoader.load_interactive(path)
	set_process(true)
	
	current_scene.queue_free()
	current_scene = load_screen.instance()
	
	root.add_child(current_scene)
