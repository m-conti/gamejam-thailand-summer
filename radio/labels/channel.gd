extends Label

func _on_radio_channel_changed(current: RadioChannel):
	text = current.display_name
