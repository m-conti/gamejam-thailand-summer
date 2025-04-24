class_name Unbreakable extends Power


func _enter_tree() -> void:
	player.collided.disconnect(player._on_collided)


func _exit_tree() -> void:
	player.collided.connect(player._on_collided)
