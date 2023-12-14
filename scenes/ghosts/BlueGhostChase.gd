extends ghostChase

# blue ghost's target is a line from blinky's position to the cell 2 tiles
# infront of pacman
# multiplied by 2

# TODO: THINK OF A FORMULA: THE CURRENT WAY IS COMPLETELY BROKEN
# BECAUSE THE POSTION COORDINATES END UP BEING ZERO

@export var red_ghost: Ghost

func enter():
	nav_agent.target_position = red_ghost.global_position - 2 * (red_ghost.global_position - (Globals.player_pos + 2 * Globals.player_dir * Globals.TILE_SIZE))


func physics_update(_delta):
	if !ghost:
		return
	var dir = ghost.to_local(nav_agent.get_next_path_position()).normalized()
	ghost.change_eye_direction(dir)
	ghost.velocity = dir * ghost.speed


func update_target():
	nav_agent.target_position = red_ghost.global_position - 2 * (red_ghost.global_position - (Globals.player_pos + 2 * Globals.player_dir * Globals.TILE_SIZE))
