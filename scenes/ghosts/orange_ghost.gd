extends Ghost
class_name OrangeGhost

# Orange ghost will target pacman directly, but will scatter when being close
# 6-8 tiles

func _ready():
	Globals.player_death.connect(_on_player_death)
	Globals.break_pen.connect(on_pen_broken)
	Globals.player_picked_powerup.connect(func(): state_machine.change_state("ghostscatter"))
	default_color = Color("ff6000")

# only player is detected
func _on_scatter_area_area_entered(_area):
	if state_machine.current_state is ghostChase:
		state_machine.change_state("ghostscatter")

func on_pen_broken():
	if state_machine.current_state is GhostIdle:
		state_machine.change_state("ghostchase")

func _on_player_death():
	if state_machine.current_state is ghostChase:
		state_machine.change_state("GhostIdle")
		can_attack = false
		if !Globals.is_game_over:
			await get_tree().create_timer(2).timeout
			state_machine.change_state("GhostChase")
			can_attack = true
