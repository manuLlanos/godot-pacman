extends Pellet



# TODO: give the player the powerup
# only the player can be detected
func _on_area_entered(_area):
	Globals.score += score
	Globals.player_picked_powerup.emit()
	queue_free()
