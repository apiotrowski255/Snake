extends Node2D

onready var audio_stream_player = $AudioStreamPlayer
var sfx_volume: float

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player.playing = true
	sfx_volume = 0.0
	audio_stream_player.volume_db = 0.0

func set_volume(new_volume: float) -> void:
	audio_stream_player.volume_db = new_volume

func get_volume() -> float:
	return audio_stream_player.volume_db
