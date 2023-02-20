extends Control

onready var play_button = $"MarginContainer/VBoxContainer/play button"
onready var two_player_button = $"MarginContainer/VBoxContainer/two player button"
onready var options_button = $"MarginContainer/VBoxContainer/options button"
onready var credits_button = $"MarginContainer/VBoxContainer/credits button"
var focused_button
onready var label = $Label


# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.grab_focus()
	focused_button = play_button


func _on_play_button_pressed():
	get_tree().change_scene("res://scenes/SinglePlayerGame.tscn")
	pass # Replace with function body.


func _on_two_player_button_pressed():
	pass # Replace with function body.


func _on_options_button_pressed():
	get_tree().change_scene("res://Menus/Options Menu.tscn")


func _on_credits_button_pressed():
	get_tree().change_scene("res://Menus/Credits Menu.tscn")


func _on_play_button_focus_entered():
	label.set_text("single player button")
	focused_button = play_button


func _on_two_player_button_focus_entered():
	label.set_text("two player button")
	focused_button = two_player_button


func _on_options_button_focus_entered():
	label.set_text("Go to options menu where you can control the volume")
	focused_button = options_button


func _on_credits_button_focus_entered():
	label.set_text("See who is responsible for this game!")
	focused_button = credits_button


func _on_play_button_mouse_entered():
	label.set_text("single player button")
	play_button.grab_focus()
	focused_button = play_button


func _on_two_player_button_mouse_entered():
	label.set_text("two player button")
	two_player_button.grab_focus()
	focused_button = two_player_button


func _on_options_button_mouse_entered():
	label.set_text("Go to options menu where you can control the volume")
	options_button.grab_focus()
	focused_button = options_button


func _on_credits_button_mouse_entered():
	label.set_text("See who is responsible for this game!")
	credits_button.grab_focus()
	focused_button = credits_button
