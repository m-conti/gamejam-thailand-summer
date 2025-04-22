extends Entity


@export var bullet_speed: float = 600

const bullet_scene: PackedScene = preload("res://entities/bullet.tscn")


func _on_bullet_shoot_timeout() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.rotation = global_position.angle_to_point(player.global_position)
	bullet.linear_velocity = bullet_speed * Vector2.from_angle(bullet.rotation)

	add_child(bullet)


func _on_police_inited(player_: Player) -> void:
	player = player_
