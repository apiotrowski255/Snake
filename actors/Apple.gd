extends Area2D
class_name Apple

onready var animation_player = $AnimationPlayer

func _ready() -> void:
	animation_player.play("idle")
