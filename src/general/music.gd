extends Node

onready var initial_track : AudioStreamOGGVorbis = preload("res://assets/music/bright-respite.ogg")
onready var player : AudioStreamPlayer = AudioStreamPlayer.new()

var target_db : float = -20.0

func _ready() -> void:
	add_child(player)
	player.stream = initial_track
	player.volume_db = -80.0
	player.play()

func _process(delta):
	if(player.volume_db != target_db):
		player.volume_db = lerp(player.volume_db, target_db, delta)

func change_track(path : String) -> void:
	var new_track = load(path)
	player.set_stream(new_track)
	player.play()
