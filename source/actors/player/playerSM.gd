extends StateMachine

func _ready():
	addState("idle")
	addState("run")
	addState("jump")
	addState("fall")
	call_deferred("setState", states.idle)
	
func _input(event: InputEvent) -> void:
	# if [states.idle, states.run].has(state): # future TODO
	
	
	if event.is_action_pressed("jump") && parent.isGrounded:
		parent.velocity.y = parent.jumpVelocity


func stateLogic(delta):
	parent.handleMoveInput()
	parent.applyGravity(delta)
	parent.applyMovement()	
	parent.cameraMovement()

func getTransition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0:
				return states.run
		states.run:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y >= 0:
					return states.fall
			elif parent.velocity.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0:
				return states.jump
	
	return null
				

func enterState(newState, oldState):

	parent.animPlayer.stop()
	
	parent.get_node("SMLabel").text = states.keys()[state]
	
	match newState:
		states.idle:
			#parent.animPlayer.stop()
			parent.animPlayer.play("idle")
		states.run:
			parent.animPlayer.play("run")
#		states.jump:
#			parent.animPlayer.play("jump")
#		states.fall:
#			parent.animPlayer.play("fall")
	pass
	# add animation states TODO
	
func exitState(oldState, newState):
	pass
