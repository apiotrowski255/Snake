extends KinematicBody2D
class_name SnakeBase

var speed: int = 4
var current_direction := Vector2.RIGHT
var new_direction : Vector2 = current_direction
onready var tween = $Tween

enum state {NORMAL, CRASH}
var current_state = state.NORMAL

