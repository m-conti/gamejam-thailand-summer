extends AnimatedSprite2D


func _on_bullet_shoot_timeout() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.rotation = global_position.angle_to_point(player.global_position)
	bullet.linear_velocity = bullet_speed * Vector2.from_angle(bullet.rotation)

	add_child(bullet)
