extends Control

func toggle_pause():
	var pause = !get_tree().paused
	get_tree().paused = pause
	%HUD.visible = !pause
	%Menu.visible = pause

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()
