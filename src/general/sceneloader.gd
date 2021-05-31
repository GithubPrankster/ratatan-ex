extends Node

var load_screen : PackedScene = preload("res://src/general/loading.tscn")

func load_scene(path : String) -> void:
	print("Lol. Lmao.")
	var inst = load_screen.instance()
	get_tree().get_root().get_node("welcome").get_node("cam").add_child(inst)
