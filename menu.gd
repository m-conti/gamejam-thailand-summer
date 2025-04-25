extends Control

func toggle_pause():
	var pause = not get_tree().paused
	get_tree().paused = pause
	%HUD.visible = not pause
	%Menu.visible = pause

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()
