extends Label

@onready
var state = self.owner as GameState

func _process(delta):
	text = "Distance : %d" % state.distance
