class_name GameOverScreen extends Control


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://level.tscn")


func _on_leader_board_pressed() -> void:
	Leaderboard.show(self)
