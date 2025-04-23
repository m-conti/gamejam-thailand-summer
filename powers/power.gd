class_name Power extends Node


var player: Player


static func add(script: Script, player_: Player) -> void:
	if player_.power:
		player_.power.queue_free()

	var node = Node.new()
	node.set_script(script)
	node.player = player_
	player_.add_child(node)

	player_.power = node
