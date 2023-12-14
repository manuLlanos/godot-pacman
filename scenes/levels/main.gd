extends Node2D

@onready var ui = %UI

@onready var pacman_scene: PackedScene = preload("res://scenes/player/pacman.tscn")
@onready var pacman_spawn_pos = $PacmanSpawn.position


func _ready():
	Globals.game_over.connect(_on_game_over)
	Globals.score_changed.connect(_on_score_changed)
	Globals.player_death.connect(_on_player_death)


func _on_player_death():
	if Globals.is_game_over:
		return
	await get_tree().create_timer(1).timeout
	var pacman = pacman_scene.instantiate()
	pacman.position = pacman_spawn_pos
	call_deferred("add_child", pacman)

# check if all pellets are gone
func _on_score_changed():
	var pellet_ammount = $Pellets.get_children().size()
	if pellet_ammount == 0:
		ui.show_victory()
		Engine.time_scale = 0
		await get_tree().create_timer(3).timeout
		Engine.time_scale = 1
		get_tree().change_scene_to_file("res://scenes/levels/main.tscn")

func _on_game_over():
	ui.show_defeat()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/levels/main.tscn")
	Globals.restart()
