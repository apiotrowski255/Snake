extends Control

onready var play_button = $"MarginContainer/VBoxContainer/play button"
onready var two_player_button = $"MarginContainer/VBoxContainer/two player button"
onready var options_button = $"MarginContainer/VBoxContainer/options button"
onready var credits_button = $"MarginContainer/VBoxContainer/credits button"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_play_button_pressed():
	pass # Replace with function body.


func _on_two_player_button_pressed():
	pass # Replace with function body.


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_credits_button_pressed():
	get_tree().change_scene("res://Menus/Credits Menu.tscn")
