extends Node

signal player_picked_powerup
signal update_ui
signal score_changed
signal game_over
signal player_death
signal break_pen

const TILE_SIZE = 32
const PEN_BREAKING_SCORE = 400

var player_pos: Vector2
var player_dir: Vector2

var pen_broken: bool = false
var is_game_over: bool = false

var score: int = 0:
	set(value):
		if !pen_broken and value >= PEN_BREAKING_SCORE:
			break_pen.emit()
			pen_broken = true
		score = value
		score_changed.emit()
		update_ui.emit()

var lives: int = 2:
	set(value):
		player_death.emit()
		if value < 0:
			game_over.emit()
			is_game_over = true
			return
		lives = value
		update_ui.emit()


func restart():
	lives = 2
	score = 0
	is_game_over = false
