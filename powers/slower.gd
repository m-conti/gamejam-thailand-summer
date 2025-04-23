class_name Slower extends Power


func _enter_tree() -> void:
    player.base_speed -= 100
    player.max_speed -= 100


func _exit_tree() -> void:
    player.base_speed += 100
    player.max_speed += 100