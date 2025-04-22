class_name GameState extends Node

var distance := 0.0

func _process(_delta):
	distance = abs(%Player.global_position.y)


func accelerate():
	pass
