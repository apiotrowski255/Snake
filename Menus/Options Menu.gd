extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var button = $Button
onready var music_volume = $"VBoxContainer/music volume"
onready var sfx_volume = $"VBoxContainer/sfx volume"


# Called when the node enters the scene tree for the first time.
func _ready():
	music_volume.value = AudioMaster.get_volume()

func _on_Button_pressed():
	get_tree().change_scene("res://Menus/Main Menu.tscn")


func _on_music_volume_value_changed(value):
	AudioMaster.set_volume(value)


func _on_sfx_volume_value_changed(value):
	AudioMaster.sfx_volume = value
