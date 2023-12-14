extends StaticBody2D

func _ready():
	Globals.break_pen.connect(open_gate)

func open_gate():
	queue_free()
