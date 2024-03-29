#extends Actor
extends KinematicBody2D

signal groundedUpdated(isGrounded)

onready var animPlayer = $AnimationPlayer

const UP = Vector2(0, -1)
const SLOPE_STOP = 64
const Projectile_PS = preload("res://source/projectiles/testProjectile.tscn")

var velocity = Vector2()
var moveSpeed= 5 * 96
var gravity = 3000
var jumpVelocity = -1000
var isGrounded
var heldProjectile = null

# onready var raycasts = $Raycasts

func cameraMovement(): #doesnt do much right now
	var wasGrounded = isGrounded
	isGrounded = is_on_floor()
	
	if wasGrounded == null || isGrounded != wasGrounded:
		emit_signal("groundedUpdated", isGrounded)

func applyGravity(delta):	
	velocity.y += gravity * delta
	
func applyMovement():
	
	velocity = move_and_slide(velocity, UP, SLOPE_STOP)
	
	isGrounded = is_on_floor() # raycasts TODO /////////////////////////////////////


func handleMoveInput():
	var moveDirection = -int(Input.is_action_pressed("moveLeft")) + int(Input.is_action_pressed("moveRight"))
	velocity.x = lerp(velocity.x, moveSpeed * moveDirection, getHWeight())
	if moveDirection != 0:
		$Body.scale.x = moveDirection
		
func getHWeight():
	return 0.2 if isGrounded else 0.1
	
func spawnProjectile():
	if heldProjectile == null:
		heldProjectile = Projectile_PS.instance()
	
func shootProjectile():
	heldProjectile.launch(1)
	heldProjectile = null
	
#func checkIsGrounded(): # implement raycasts /////////////////////////
#	for raycast in raycasts.get_children():
#		if raycast.is_colliding():
#			return true
#
#	return false # loop completes
	
	
#///////////////////////////////// OLD //////////////////////////

#func _physics_process(delta: float) -> void:
#	var direction: = getDirection()
#	_velocity = calculateMoveVelocity(_velocity, direction, speed)
#	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
#
#func getDirection() -> Vector2:
#	return Vector2(
#		Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft"),
#		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
#	)
#
#func calculateMoveVelocity(
#		linearVelocity: Vector2,
#		direction: Vector2,
#		speed: Vector2
#	) -> Vector2:
#	var out: = linearVelocity
#	out.x = speed.x * direction.x
#	out.y += gravity * get_physics_process_delta_time()
#	if direction.y == -1.0:
#		out.y = speed.y * direction.y
#	return out
