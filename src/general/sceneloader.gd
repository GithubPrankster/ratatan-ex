extends Node

# Is it safe to be doing level switching?
var load_safety : bool = true

var load_screen : PackedScene = preload("res://src/general/loading.tscn")

func load_scene(path : String) -> void:
	if load_safety: # Failsafe to keep goofballs out
		load_safety = false
	else:
		return
	
	print("Lol. Lmao.")
	var inst = load_screen.instance()
	get_tree().get_root().get_node("welcome").get_node("cam").add_child(inst)
	Music.target_db = -80.0
	
	# TODO: Turnback load safety once all the business is taken care of
