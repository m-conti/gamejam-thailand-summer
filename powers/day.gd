class_name Day extends Power


func _enter_tree() -> void:
    player.owner.get_node("%NightFilter").visible = false
    player.get_node("%Lights").visible = false


func _exit_tree() -> void:
    player.owner.get_node("%NightFilter").visible = true
    player.get_node("%Lights").visible = true