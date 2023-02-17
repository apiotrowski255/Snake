extends Node2D

onready var snake = $Snake
onready var explosion_holder = $explosion_holder

# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	snake.self_colliding()
	for child in explosion_holder.get_children():
		if child.emitting == false:
			child.queue_free()

func get_apple_or_null() -> Area2D:
	for child in self.get_children():
		if child is Area2D and child.name != "Surrounding walls":
			return child
	return null

func spawn_explosion() -> void:
	var explosion = load("res://actors/eating_apple_explosion.tscn").instance()
	explosion.emitting = true
	explosion.global_position = snake.snake_head.global_position
	if snake.snake_head.current_direction == Vector2.RIGHT:
		explosion.global_position.x += 16
	elif snake.snake_head.current_direction == Vector2.UP:
		explosion.global_position.y -= 16
	elif snake.snake_head.current_direction == Vector2.LEFT:
		explosion.global_position.x -= 16
	elif snake.snake_head.current_direction == Vector2.DOWN:
		explosion.global_position.y += 16
	explosion_holder.add_child(explosion)

func _on_Apple_body_entered(body):
	get_apple_or_null().queue_free()
	spawn_explosion()
	snake.grow_snake()
	spawn_new_apple()

func is_position2D_overlap_snake(position : Vector2) -> bool:
	for snake in $Snake.get_children():
		if position.distance_to(snake.global_position) < 32:
			return true
	return false

func spawn_new_apple() -> void:
	randomize()
	var x = (randi() % 30) + 1
	var y = (randi() % 17) + 1
	var position = Vector2(x * 32 + 16, y * 32 + 16)
	while is_position2D_overlap_snake(position) == true:
		x = (randi() % 30) + 1
		y = (randi() % 17) + 1
		position = Vector2(x * 32 + 16, y * 32 + 16)
	var apple = load("res://actors/Apple.tscn").instance()
	apple.name = "Apple"
	apple.connect("body_entered", self, "_on_Apple_body_entered")
	apple.global_position = position
	self.add_child(apple, true)
	


func _on_Surrounding_walls_body_entered(body):
	snake.crash()
