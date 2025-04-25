extends Label

func _on_radio_sound_changed(current: RadioSound):
	text = current.display_name
