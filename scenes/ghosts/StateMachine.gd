extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	#print(current_state)
	if current_state:
		current_state.physics_update(delta)

func change_state(new_state_name):
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state


func _on_nav_timer_timeout():
	if "update_target" in current_state:
		current_state.update_target()


func get_current_state_name():
	return str(current_state)
