extends CanvasLayer

@onready var lives_label = %LivesLabel
@onready var score_label = %ScoreLabel

func _ready():
	$Victory.hide()
	$Defeat.hide()
	Globals.update_ui.connect(_on_update_ui)
	lives_label.text = str(Globals.lives)
	score_label.text = str(Globals.score)

func _on_update_ui():
	lives_label.text = str(Globals.lives)
	score_label.text = str(Globals.score)

func show_victory():
	$Victory.show()

func show_defeat():
	$Defeat.show()
