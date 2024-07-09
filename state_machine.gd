class_name StateMachine extends Node

@export var CURRENT_STATE: State
var states: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transition.connect(on_child_transition)
		else:
			push_error("This state machine contains an invalid children")
	
	if CURRENT_STATE == null:
		push_error("Default CURRENT_STATE not set for thi state machine")
	CURRENT_STATE.enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	CURRENT_STATE.update(delta)
	Global.debug.add_property("PlayerState", CURRENT_STATE, 1)

func _physics_process(delta) -> void:
	CURRENT_STATE.physics_update(delta)

func _input(event: InputEvent): # Tramite questa funzione si evita di controllare nell'update degli state se degli input vengono attivati
	CURRENT_STATE.handle_input(event) #In questo modo se arriva un interrupt chiamo l'handle solo dello state attuale

func on_child_transition(new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)
	if new_state:
		CURRENT_STATE.exit()
		CURRENT_STATE = new_state
		CURRENT_STATE.enter()
	else:
		push_warning("The new state passed in the transition does not exists")
