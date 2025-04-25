class_name GameState extends Node

var distance := 0.0
var sound_level := -10

func _process(_delta):
	distance = abs(%Player.global_position.y)

func _ready():
	print_debug(sound_level)

func accelerate():
	pass
