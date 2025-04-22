extends Label


@onready var state: GameState = owner


func _process(_delta):
	text = "Distance : %d" % state.distance
