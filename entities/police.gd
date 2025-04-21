class_name Police extends Entity


const bullet_scene: PackedScene = preload("res://entities/bullet.tscn")


@export var bullet_speed: float = 100


func _on_bullet_shoot_timeout() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.rotation = position.angle_to_point(player.position)
	bullet.linear_velocity = bullet_speed * Vector2.from_angle(bullet.rotation)

	add_child(bullet)
