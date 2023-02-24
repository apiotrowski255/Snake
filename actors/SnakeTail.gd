extends SnakeBase
var object_to_follow

func load_texture(texture: Texture) -> void:
	$GreenSquare.texture = texture

func _process(delta):
	# For some reason putting this code after the if statements will cause it to break
	move_and_collide(speed * current_direction)
	if current_state == state.NORMAL:
		global_position.x = int(global_position.x)
		global_position.y = int(global_position.y)
	if current_direction == Vector2.RIGHT:
		if global_position.x == object_to_follow.global_position.x:
			if global_position.y < object_to_follow.global_position.y:
				current_direction = Vector2.DOWN
			elif global_position.y > object_to_follow.global_position.y:
				current_direction = Vector2.UP
	elif current_direction == Vector2.LEFT:
		if global_position.x == object_to_follow.global_position.x:
			if global_position.y < object_to_follow.global_position.y:
				current_direction = Vector2.DOWN
			elif global_position.y > object_to_follow.global_position.y:
				current_direction = Vector2.UP
	elif current_direction == Vector2.UP:
		if global_position.y == object_to_follow.global_position.y:
			if global_position.x < object_to_follow.global_position.x:
				current_direction = Vector2.RIGHT
			elif global_position.x > object_to_follow.global_position.x:
				current_direction = Vector2.LEFT
	elif current_direction == Vector2.DOWN:
		if global_position.y == object_to_follow.global_position.y:
			if global_position.x < object_to_follow.global_position.x:
				current_direction = Vector2.RIGHT
			elif global_position.x > object_to_follow.global_position.x:
				current_direction = Vector2.LEFT
				
	

func crash() -> void:
	randomize()
	current_direction = current_direction.rotated(rand_range(-PI/4, PI/4))
	tween.interpolate_property(self, "speed", speed, 0, rand_range(1.0, 3.0), 0, 1)
	tween.start()
