extends CharacterBody2D
class_name Ghost
@export var max_speed: int = 135
@export var score: int = 100

@onready var speed = max_speed
@onready var eyes = %Eyes
@onready var nav_agent = %NavigationAgent2D
@onready var state_machine = %StateMachine

# add a marker2d that is the scatter target, each ghost has to scatter to
# one corner, once reached, they return to chasing
# also a marker for the position where they return to the house after dying
# if the player picks the powerup, all active ghosts scatter

var default_color: Color = Color(1, 0, 0, 1)
var can_attack: bool = true
var vulnerable: bool = false

func _ready():
	Globals.player_death.connect(_on_player_death)
	Globals.player_picked_powerup.connect(func(): state_machine.change_state("ghostscatter"))

func _physics_process(_delta):
	move_and_slide()

func change_eye_direction(dir):
	var facing_dir = Vector2(round(dir.x), round(dir.y))
	match facing_dir:
		Vector2.RIGHT:
			eyes.frame = 0
		Vector2.DOWN:
			eyes.frame = 1
		Vector2.LEFT:
			eyes.frame = 2
		Vector2.UP:
			eyes.frame = 3

func hit():
	Globals.score += score
	state_machine.change_state("GhostGoHome")


func _on_navigation_agent_2d_navigation_finished():
	if ! (state_machine.current_state is ghostChase):
		state_machine.change_state("ghostchase")


# weird way of making a safe respawn, goal of this project was to do ai
func _on_player_death():
	if state_machine.current_state is ghostChase:
		state_machine.change_state("GhostIdle")
		can_attack = false
		if !Globals.is_game_over:
			await get_tree().create_timer(2).timeout
			state_machine.change_state("GhostChase")
			can_attack = true
