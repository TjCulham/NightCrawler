extends Node
class_name StateMachine

var state = null setget setState
var previousState = null
var states = {}

onready var parent = get_parent()

func _physics_process(delta: float) -> void:
	if state != null:
		stateLogic(delta)
		var transition = getTransition(delta)
		if transition != null:
			setState(transition)
	
func stateLogic(delta):
	pass	

func getTransition(delta):
	return null

func enterState(newState, oldState):
	pass
	
func exitState(oldState, newState):
	pass
	
func setState(newState):
	previousState = state
	state = newState
	
	if previousState != null:
		exitState(previousState, newState)
	elif newState != null:
		enterState(newState, previousState)
		
func addState(stateName):
	states[stateName] = states.size()
	
	
