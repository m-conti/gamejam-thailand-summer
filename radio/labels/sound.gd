extends Label


@onready var state: GameState = owner.owner


func _on_radio_sound_changed(current: RadioSound):
	text = current.display_name
