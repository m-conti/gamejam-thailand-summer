class_name Leaderboard extends Node


@export var n_first: int = 10

const score_line_scene: PackedScene = preload("res://leaderboard/score_line.tscn")
const leaderboard_scene: PackedScene = preload("res://leaderboard/leaderboard.tscn")

@onready var loading: Label = %Loading

static var scene_to_hide


static func show(scene_to_hide_: Node):
	scene_to_hide = scene_to_hide_
	scene_to_hide.visible = false
	var leaderboard = leaderboard_scene.instantiate()
	scene_to_hide.get_parent().add_child(leaderboard)


func add_score_line(line):
	var score_line = score_line_scene.instantiate()
	score_line.get_node("%Name").text = line.player.name
	score_line.get_node("%Score").text = str(line.score)
	score_line.get_node("%Rank").text = str(int(line.rank))
	%Container.add_child(score_line)


func _ready():
	loading.show()

	var leaderboard: Dictionary = await Server.get_leaderboards()
	if "items" in leaderboard:
		for line in leaderboard.items:
			add_score_line(line)
	
	loading.hide()


func _on_back_pressed():
	scene_to_hide.visible = true
	queue_free()
