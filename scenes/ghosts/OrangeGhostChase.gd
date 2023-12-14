extends ghostChase


# Orange ghost will target pacman directly, but will scatter when being close
# 6-8 tiles

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
