extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/HBoxContainer/Button.grab_focus()



func _on_Button_pressed():
	# return to the main menu
	get_tree().change_scene("res://Menus/Main Menu.tscn")
	AudioMaster.play_sfx("res://audio/vgmenuselect.wav")
