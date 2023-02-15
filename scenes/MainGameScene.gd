extends Node2D

onready var snake = $Snake

# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	snake.self_colliding()

func get_apple_or_null() -> Area2D:
	for child in self.get_children():
		if child is Area2D and child.name != "Surrounding walls":
			return child
	return null
	
func _on_Apple_body_entered(body):
	get_apple_or_null().queue_free()
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
		x = (randi() % 28) + 2
		y = (randi() % 15) + 2
		position = Vector2(x * 32 + 16, y * 32 + 16)
	var apple = load("res://actors/Apple.tscn").instance()
	apple.name = "Apple"
	apple.connect("body_entered", self, "_on_Apple_body_entered")
	apple.global_position = position
	self.add_child(apple, true)
	


func _on_Surrounding_walls_body_entered(body):
	print("Snake hitting edge wall")
