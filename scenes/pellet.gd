extends Area2D
class_name Pellet

## How much score this pellet is worth
@export var score: int = 5




func _on_area_entered(_area):
	Globals.score += score
	queue_free()
