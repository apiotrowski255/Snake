extends SnakeBase


func _process(delta):
	if current_state == state.NORMAL:
		if Input.is_action_pressed("ui_left"):
			if current_direction != Vector2.RIGHT:
				if (int(global_position.x) - 16) % 32 == 0 and (int(global_position.y) - 16) % 32  == 0:
					current_direction = Vector2.LEFT
					new_direction = Vector2.LEFT
				else:
					new_direction = Vector2.LEFT
		elif Input.is_action_pressed("ui_right"):
			if current_direction != Vector2.LEFT:
				if (int(global_position.x) - 16) % 32 == 0 and (int(global_position.y) - 16) % 32  == 0:
					current_direction = Vector2.RIGHT
					new_direction = Vector2.RIGHT
				else:
					new_direction = Vector2.RIGHT
		elif Input.is_action_pressed("ui_up"):
			if current_direction != Vector2.DOWN:
				if (int(global_position.x) - 16) % 32 == 0 and (int(global_position.y) - 16) % 32  == 0:
					current_direction = Vector2.UP
					new_direction = Vector2.UP
				else:
					new_direction = Vector2.UP
		elif Input.is_action_pressed("ui_down"):
			if current_direction != Vector2.UP:
				if (int(global_position.x) - 16) % 32 == 0 and (int(global_position.y) - 16) % 32  == 0:
					current_direction = Vector2.DOWN
					new_direction = Vector2.DOWN
				else:
					new_direction = Vector2.DOWN
				
		if (int(global_position.x) - 16) % 32 == 0 and (int(global_position.y) - 16) % 32  == 0 and new_direction != null and new_direction != current_direction:
			current_direction = new_direction
	
	move_and_collide(speed * current_direction)
	if current_state == state.NORMAL:
		global_position.x = int(global_position.x)
		global_position.y = int(global_position.y)


func crash() -> void:
	randomize()
	current_direction = current_direction.rotated(rand_range(-PI/8, PI/8))
	tween.interpolate_property(self, "speed", speed, 0, rand_range(2.0, 4.0), 0, 1)
	tween.start()
