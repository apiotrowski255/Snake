extends Node2D

var length : int = 0

onready var snake_head = $SnakeHead
onready var snake_tail = $SnakeTail
onready var snake_tail_2 = $SnakeTail2
onready var snake_tail_3 = $SnakeTail3
var tail

signal snake_died

# Called when the node enters the scene tree for the first time.
func _ready():
	snake_tail.object_to_follow = snake_head
	snake_tail_2.object_to_follow = snake_tail
	snake_tail_3.object_to_follow = snake_tail_2
	tail = snake_tail_3
	length = 4
	pass # Replace with function body.

func self_colliding() -> bool:
	for snake_body in self.get_children():
		if snake_body.global_position == snake_head.global_position:
			pass
		elif snake_head.global_position.distance_to(snake_body.global_position) < 12 and snake_head.current_state != SnakeBase.state.CRASH:
			print("Snake is colliding with itself")
			emit_signal("snake_died")
			crash()
			return true
	return false

func get_tail() -> SnakeBase: 
	return tail

# Duplicates the tail of the snake and then when there is space, tail starts to follow the snake
func grow_snake():
	var new_snake_tail = load("res://actors/SnakeTail.tscn").instance()
	self.add_child(new_snake_tail)
	new_snake_tail.object_to_follow = tail
	new_snake_tail.global_position = tail.global_position
	new_snake_tail.current_direction = tail.current_direction
	if tail.current_direction == Vector2.RIGHT:
		new_snake_tail.global_position.x -= 32
	elif tail.current_direction == Vector2.DOWN:
		new_snake_tail.global_position.y -= 32
	elif tail.current_direction == Vector2.LEFT:
		new_snake_tail.global_position.x += 32
	elif tail.current_direction == Vector2.UP:
		new_snake_tail.global_position.y += 32
	tail = new_snake_tail
	length += 1

# function is called when the snake crashes with itself
func crash() -> void:
	print("start crash")
	for snake_part in self.get_children():
		snake_part.current_state = SnakeBase.state.CRASH
		snake_part.crash()
	pass
