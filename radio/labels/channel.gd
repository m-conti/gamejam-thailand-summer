extends Label


@onready var state: GameState = owner.owner


func _on_radio_channel_changed(current: RadioChannel):
	text = current.display_name
