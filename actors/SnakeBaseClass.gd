extends KinematicBody2D
class_name SnakeBase

var speed := 4
var current_direction := Vector2.RIGHT
var new_direction : Vector2 = current_direction
onready var tween = $Tween

enum state {NORMAL, CRASH}
var current_state = state.NORMAL
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
