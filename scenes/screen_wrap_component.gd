extends Node2D

@onready var parent = get_parent()
@onready var viewport_size: Vector2 = get_viewport_rect().size

func _ready():
	if !parent:
		push_error("SCREEN WRAP COMPONENT NEEDS A PARENT")

func _physics_process(_delta):
	parent.global_position = parent.global_position.posmodv(viewport_size)
