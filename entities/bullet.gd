class_name Bullet extends RigidBody2D


func _on_body_entered(body: Node) -> void:
	if body is not Player:
		return
	body.shooted()
	queue_free()
