extends Node2D

onready var snake = $Snake
onready var explosion_holder = $explosion_holder
onready var timer = $Timer
onready var canvas_modulate = $CanvasModulate
onready var tween = $Tween
onready var label = $CanvasLayer/Control/CenterContainer/VBoxContainer/Label
onready var countdown = $CanvasLayer/Control/CenterContainer/countdown
onready var v_box_container = $CanvasLayer/Control/CenterContainer/VBoxContainer



func _ready():
	canvas_modulate.show()
	canvas_modulate.color = Color(.4, .4, .4)
	v_box_container.hide()
	
	snake.set_speed(0)
	snake.global_position.y = random_y_value()
	$Apple_holder/Apple.global_position = random_free_spot()
	$Apple_holder/Apple2.global_position = random_free_spot()
	$Apple_holder/Apple3.global_position = random_free_spot()
	
	$Apple_holder/Apple.connect("body_entered", self, "_on_Apple_body_entered", [$Apple_holder/Apple])
	$Apple_holder/Apple2.connect("body_entered", self, "_on_Apple_body_entered", [$Apple_holder/Apple2])
	$Apple_holder/Apple3.connect("body_entered", self, "_on_Apple_body_entered", [$Apple_holder/Apple3])
	
	countdown.show()
	countdown.text = "3"
	timer.start(1.0)
	yield(timer, "timeout")
	
	countdown.text = "2"
	timer.start(1.0)
	yield(timer, "timeout")
	
	countdown.text = "1"
	timer.start(1.0)
	yield(timer, "timeout")
	
	countdown.hide()
	canvas_modulate.hide()
	snake.set_speed(4)
	

func random_y_value() -> int:
	randomize()
	var i = randi() % 17 + 1
	var y = 16 + 32 * i
	return y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	snake.self_colliding()
	for child in explosion_holder.get_children():
		if child.emitting == false:
			child.queue_free()

func get_closest_apple(position: Vector2):
	var distance = 10000
	var closest_apple = null
	for apple in $Apple_holder.get_children():
		if apple.global_position.distance_to(position) < distance:
			distance = apple.global_position.distance_to(position)
			closest_apple = apple
	return closest_apple

func spawn_explosion() -> void:
	var explosion = load("res://actors/eating_apple_explosion.tscn").instance()
	
	explosion_holder.add_child(explosion)
	explosion.global_position = snake.snake_head.global_position
	if snake.snake_head.current_direction == Vector2.RIGHT:
		explosion.global_position.x += 16
	elif snake.snake_head.current_direction == Vector2.UP:
		explosion.global_position.y -= 16
	elif snake.snake_head.current_direction == Vector2.LEFT:
		explosion.global_position.x -= 16
	elif snake.snake_head.current_direction == Vector2.DOWN:
		explosion.global_position.y += 16
	explosion.emitting = true

func _on_Apple_body_entered(body, apple):
	apple.queue_free()
	spawn_explosion()
	snake.grow_snake()
	spawn_new_apple()
	AudioMaster.play_sfx("res://audio/atari_boom.wav")

func is_position2D_overlap_snake(position : Vector2) -> bool:
	for snake in $Snake.get_children():
		if position.distance_to(snake.global_position) < 32:
			return true
	return false

func spawn_new_apple() -> void:
	var position = random_free_spot()
	var apple = load("res://actors/Apple.tscn").instance()
	apple.name = "Apple"
	apple.global_position = position
	apple.connect("body_entered", self, "_on_Apple_body_entered", [apple])
	$Apple_holder.add_child(apple, true)

func spawn_block() -> void:
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
	while is_position2D_overlap_snake(position) or is_position2D_overlap_apple(position):
		x = (randi() % 30) + 1
		y = (randi() % 17) + 1
		position = Vector2(x * 32 + 16, y * 32 + 16)
	return position

func is_position2D_overlap_apple(position) -> bool:
	for apple in $Apple_holder.get_children():
		if position == apple.global_position:
			return true
	return false

func _on_Surrounding_walls_body_entered(body):
	snake.crash()


func _on_Snake_snake_died():
	AudioMaster.slowly_change_volume(AudioMaster.get_volume() - 15, 2)
	timer.start(1.0)
	yield(timer, "timeout")
	canvas_modulate.color = Color(1,1,1,1)
	tween.interpolate_property(canvas_modulate, "color", Color(1, 1, 1, 1), Color(.4, .4, .4, 1), 2.0)
	canvas_modulate.show()
	tween.start()
	yield(tween, "tween_all_completed")
	label.set_text("Game Over! \nYour final Length is: " + str(snake.length))
	v_box_container.show()
	$CanvasLayer/Control/CenterContainer/VBoxContainer/Button2.grab_focus()
	


func _on_Button_pressed():
	AudioMaster.slowly_change_volume(AudioMaster.get_volume() + 15, 1)
	get_tree().change_scene("res://Menus/Main Menu.tscn")
	AudioMaster.play_sfx("res://audio/vgmenuselect.wav")

func _on_Button2_pressed():
	AudioMaster.slowly_change_volume(AudioMaster.get_volume() + 15, 1)
	get_tree().change_scene("res://scenes/SinglePlayerGame.tscn")
	AudioMaster.play_sfx("res://audio/vgmenuselect.wav")
