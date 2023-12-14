extends Area2D

@onready var sprite= %Sprite2D
@onready var move_timer = %MoveTimer
@onready var ray = %RayCast2D

@export var speed: int = 96
@export var move_time: float = 0.5

# make this like frogger, but have a timer that keeps the pacman
# moving automatically when possible (detect collision with a raycast)
# to keep it simple, cus dealing with tile ids and coords is a pain in the ass


var inputs: Dictionary = {
	"up": Vector2.UP,
	"down": Vector2.DOWN,
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT
	}

var direction: Vector2 = Vector2.RIGHT
var tween: Tween

func _ready():
	$AnimationPlayer.play("moving")
	move_timer.wait_time = move_time
	move_timer.autostart = true
	move_timer.timeout.connect(move)
	move_timer.start()


func _physics_process(_delta):
	for input in inputs:
		if Input.is_action_pressed(input):
			change_dir(inputs[input])
	Globals.player_pos = global_position
	Globals.player_dir = direction

func change_dir(dir):
	ray.target_position = dir * Globals.TILE_SIZE
	ray.force_raycast_update()
	if !ray.is_colliding():
		direction = dir
		sprite.look_at(position + dir)

func move():
	ray.target_position = direction * Globals.TILE_SIZE
	ray.force_raycast_update()
	if ray.is_colliding():
		return
	tween = create_tween()
	tween.tween_property(self, "position", position + direction * Globals.TILE_SIZE, move_time)
	tween.finished.connect(snap_position)

func snap_position():
	position = position.snapped(Vector2. ONE * Globals.TILE_SIZE/2)

# only ghosts can be detected
func _on_body_entered(body):
	if body is Ghost:
		if body.can_attack:
			hit()
		elif body.vulnerable:
			body.hit()

func hit():
	print("pacman has been hit")
	Globals.lives -= 1
	queue_free()
