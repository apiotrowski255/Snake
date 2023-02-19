extends Node2D

onready var snake = $Snake
onready var explosion_holder = $explosion_holder

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer = $Timer
onready var canvas_modulate = $CanvasModulate
onready var tween = $Tween
onready var canvas_layer = $CanvasLayer
onready var label = $CanvasLayer/Control/CenterContainer/VBoxContainer/Label



# Called when the node enters the scene tree for the first time.
func _ready():
	canvas_modulate.hide()
	canvas_layer.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	snake.self_colliding()
	for child in explosion_holder.get_children():
		if child.emitting == false:
			child.queue_free()

# The thing is, there should always be an apple in the scene
func get_apple_or_null() -> Area2D:
	for child in self.get_children():
		if child is Apple and child.name != "Surrounding walls":
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
	var position = random_free_spot()
	var apple = load("res://actors/Apple.tscn").instance()
	apple.name = "Apple"
	apple.connect("body_entered", self, "_on_Apple_body_entered")
	apple.global_position = position
	self.add_child(apple, true)
	var collisionshape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(10, 10)
	collisionshape.set_shape(shape)
	collisionshape.global_position = random_free_spot()
	self.get_node("Surrounding walls").add_child(collisionshape)
	
func random_free_spot() -> Vector2:
	randomize()
	var x = (randi() % 30) + 1
	var y = (randi() % 17) + 1
	var position = Vector2(x * 32 + 16, y * 32 + 16)
	while is_position2D_overlap_snake(position) == true:
		x = (randi() % 30) + 1
		y = (randi() % 17) + 1
		position = Vector2(x * 32 + 16, y * 32 + 16)
	return position


func _on_Surrounding_walls_body_entered(body):
	snake.crash()


func _on_Snake_snake_died():
	timer.start(1.0)
	yield(timer, "timeout")
	canvas_modulate.show()
	tween.interpolate_property(canvas_modulate, "color", Color(1, 1, 1, 1), Color(.4, .4, .4, 1), 2.0)
	tween.start()
	yield(tween, "tween_all_completed")
	label.set_text("Game Over! \nYour final Length is: " + str(snake.length))
	canvas_layer.show()

func _on_Button_pressed():
	get_tree().change_scene("res://Menus/Main Menu.tscn")

func _on_Button2_pressed():
	get_tree().change_scene("res://scenes/SinglePlayerGame.tscn")
