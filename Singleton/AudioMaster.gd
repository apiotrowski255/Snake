extends Node2D

onready var sfx = $sfx
onready var audio_stream_player = $AudioStreamPlayer
onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player.playing = true
	sfx.volume_db = -20.0
	audio_stream_player.volume_db = -4.0

func set_volume(new_volume: float) -> void:
	audio_stream_player.volume_db = new_volume

func get_volume() -> float:
	return audio_stream_player.volume_db

func play_sfx(sound: String) -> void:
	sfx.set_stream(load(sound)) 
	sfx.play()

func slowly_change_volume(new_volume: float, time: float):
	tween.interpolate_property(audio_stream_player, "volume_db", get_volume(), new_volume, time)
	tween.start()

func set_sfx_volume(new_volume: float) -> void:
	sfx.volume_db = new_volume

func get_sfx_volume() -> float:
	return sfx.volume_db
