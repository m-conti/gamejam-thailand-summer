class_name Power extends Node


var player: Player


static func create(script: Script, player_: Player) -> Power:
	var node = Node.new()
	node.set_script(script)
	node.player = player_
	player_.add_child(node)

	return node as Power
