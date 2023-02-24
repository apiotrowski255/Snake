extends Control

onready var play_button = $"MarginContainer/VBoxContainer/play button"
onready var hard_button = $"MarginContainer/VBoxContainer/play button2"
onready var options_button = $"MarginContainer/VBoxContainer/options button"
onready var credits_button = $"MarginContainer/VBoxContainer/credits button"
var focused_button
onready var label = $Label


func _on_play_button_pressed():
	get_tree().change_scene("res://scenes/SinglePlayerGame.tscn")
	AudioMaster.play_sfx("res://audio/vgmenuselect.wav")




func _unhandled_input(event):
	if focused_button == null:
		play_button.grab_focus()
		focused_button = play_button


func _on_options_button_pressed():
	get_tree().change_scene("res://Menus/Options Menu.tscn")
	AudioMaster.play_sfx("res://audio/vgmenuselect.wav")


func _on_credits_button_pressed():
	get_tree().change_scene("res://Menus/Credits Menu.tscn")
	AudioMaster.play_sfx("res://audio/vgmenuselect.wav")


func _on_play_button_focus_entered():
	label.set_text("play single player mode!\nuse WASD or arrow keys to control the snake")
	focused_button = play_button
	AudioMaster.play_sfx("res://audio/MENU_Pick.wav")



func _on_options_button_focus_entered():
	label.set_text("Go to options menu where you can control the volume")
	focused_button = options_button
	AudioMaster.play_sfx("res://audio/MENU_Pick.wav")


func _on_credits_button_focus_entered():
	label.set_text("See who is responsible for this game!")
	focused_button = credits_button
	AudioMaster.play_sfx("res://audio/MENU_Pick.wav")


func _on_play_button_mouse_entered():
	label.set_text("play single player mode!\nuse WASD or arrow keys to control the snake")
	play_button.grab_focus()
	focused_button = play_button
	AudioMaster.play_sfx("res://audio/MENU_Pick.wav")



func _on_options_button_mouse_entered():
	label.set_text("Go to options menu where you can control the volume")
	options_button.grab_focus()
	focused_button = options_button
	AudioMaster.play_sfx("res://audio/MENU_Pick.wav")


func _on_credits_button_mouse_entered():
	label.set_text("See who is responsible for this game!")
	credits_button.grab_focus()
	focused_button = credits_button
	AudioMaster.play_sfx("res://audio/MENU_Pick.wav")
	


func _on_play_button2_pressed():
	get_tree().change_scene("res://scenes/TwoPlayerGame.tscn")
	AudioMaster.play_sfx("res://audio/vgmenuselect.wav")


func _on_play_button2_focus_entered():
	label.set_text("This mode might be a bit unfair...")
	focused_button = play_button
	AudioMaster.play_sfx("res://audio/MENU_Pick.wav")


func _on_play_button2_mouse_entered():
	label.set_text("This mode might be a bit unfair...")
	focused_button = play_button
	AudioMaster.play_sfx("res://audio/MENU_Pick.wav")
