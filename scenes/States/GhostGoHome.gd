extends State
class_name ghostGoHome


# goes to home base and respawns

@export var ghost: CharacterBody2D
@export var nav_agent: NavigationAgent2D
@export var home_target: Marker2D

func enter():
	nav_agent.target_position = home_target.global_position
	ghost.vulnerable = false
	ghost.can_attack = false
	ghost.speed = 0.5 * ghost.max_speed
	%Body.hide()

func exit():
	ghost.vulnerable = false
	ghost.can_attack = true
	ghost.speed = ghost.max_speed
	%Body.show()
	%Body.self_modulate = ghost.default_color

func physics_update(_delta: float):
	if !ghost:
		return
	var dir = ghost.to_local(nav_agent.get_next_path_position()).normalized()
	ghost.change_eye_direction(dir)
	ghost.velocity = dir * ghost.speed

func update_target():
	nav_agent.target_position = home_target.global_position
