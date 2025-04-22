class_name Entity extends Node2D


signal inited(player: Player)
var player: Player


func init(player_: Player):
	player = player_
	inited.emit(player)
