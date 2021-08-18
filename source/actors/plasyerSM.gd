extends "res://state machine/stateMachine.gd"

func ready():
	addState("idle")
	addState("run")
	addState("jump")
	addState("fall")
	call_deferred("setState", states.idle)
	
func stateLogic(delta):
	parent.handle	

func getTransition(delta):
	return null

func enterState(newState, oldState):
	pass
	
func exitState(oldState, newState):
	pass
