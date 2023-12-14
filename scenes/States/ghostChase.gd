extends State
class_name ghostChase

# the direct chase, used by red
# goes straight for the player

@export var ghost: CharacterBody2D
@export var nav_agent: NavigationAgent2D
# player position is a global

func enter():
	nav_agent.target_position = Globals.player_pos


func physics_update(_delta):
	if !ghost:
		return
	var dir = ghost.to_local(nav_agent.get_next_path_position()).normalized()
	ghost.change_eye_direction(dir)
	ghost.velocity = dir * ghost.speed


func update_target():
	nav_agent.target_position = Globals.player_pos
