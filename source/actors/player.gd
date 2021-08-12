extends Actor

func _physics_process(delta: float) -> void:
	var direction: = getDirection()
	_velocity = calculateMoveVelocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func getDirection() -> Vector2:
	return Vector2(
		Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	
func calculateMoveVelocity(
		linearVelocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var out: = linearVelocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	return out
