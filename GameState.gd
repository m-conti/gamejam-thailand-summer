class_name GameState extends Node

var distance := 0.0

func _process(delta):
	distance = abs(%Player.global_position.y)


func accelerate():
	distance
