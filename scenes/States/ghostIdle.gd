extends State
class_name GhostIdle

# in this state ghost just stand still until  they are activated
# pink, blue and orange should start like this until the pen is open

@export var ghost: CharacterBody2D

func enter():
	ghost.velocity = Vector2.ZERO
	if ghost is OrangeGhost:
		ghost.get_node("ScatterArea").monitoring = false

func exit():
	print("exiting idle state")
	if ghost is OrangeGhost:
		ghost.get_node("ScatterArea").monitoring = true
