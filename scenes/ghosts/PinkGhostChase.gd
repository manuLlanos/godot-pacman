extends ghostChase

# pink tries to get ahead of the player by 4 tiles

func enter():
	nav_agent.target_position = Globals.player_pos + 4 * Globals.player_dir * Globals.TILE_SIZE


func physics_update(_delta):
	if !ghost:
		return
	var dir = ghost.to_local(nav_agent.get_next_path_position()).normalized()
	ghost.change_eye_direction(dir)
	ghost.velocity = dir * ghost.speed


func update_target():
	nav_agent.target_position = Globals.player_pos + 4 * Globals.player_dir * Globals.TILE_SIZE
