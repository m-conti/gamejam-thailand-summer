class_name CanEat extends Power


func _enter_tree() -> void:
	player.eating_zone.body_entered.connect(player._on_eating_zone_body_entered)


func _exit_tree() -> void:
	player.eating_zone.body_entered.disconnect(player._on_eating_zone_body_entered)
