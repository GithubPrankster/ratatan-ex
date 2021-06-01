extends Node

var load_screen : PackedScene = preload("res://src/general/loading.tscn")
var current_scene = null
var loader : ResourceInteractiveLoader = null

var wait_frames = 1
var time_max = 100 # msec
var blocker : bool = false

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)
	Music.target_db = 0.0

func _process(delta):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return

	var t = OS.get_ticks_msec()
	# Use "time_max" to control for how long we block this thread.
	while OS.get_ticks_msec() < t + time_max:
		# Poll your loader.
		var err = loader.poll()

		if err == ERR_FILE_EOF: # Finished loading.
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		elif err != OK:
			print("WOW.", err)
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
	
	get_node("/root").add_child(load_screen.instance())
	
