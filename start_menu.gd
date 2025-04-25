extends Control

@onready var line_edit: LineEdit = %LineEdit
var pseudo:
	get: return line_edit.text


func _ready() -> void:
	line_edit.text = await Server.get_player_name()


func shake_animation():
	line_edit.modulate = Color(1, 0, 0)
	for i in range(10):
		var tween = create_tween().tween_property(self, "position", Vector2(randf_range(-10, 10), randf_range(-10, 10)), 0.05)
		await tween.finished
	line_edit.modulate = Color(1, 1, 1)
	create_tween().tween_property(self, "position", Vector2.ZERO, 0.05)


func _on_play_pressed() -> void:
	if pseudo == "":
		shake_animation()
		return
	
	await Server.change_player_name(pseudo)
	get_tree().change_scene_to_file("res://level.tscn")


func _on_leader_board_pressed() -> void:
	Leaderboard.show(self)
