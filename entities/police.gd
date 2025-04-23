class_name Police extends Entity


var crashed: bool = false

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if crashed or state.get_contact_count() == 0:
		return

	var body = state.get_contact_collider_object(0)

	if body is Player or body is Entity:
		if body is Player:
			body.collided.emit(self)

		var collision_point = state.get_contact_local_position(0)
		var smoke = preload("res://particles/smoke.tscn").instantiate()
		add_child(smoke)
		smoke.global_position = collision_point

		%AnimationPlayer.play("crash")
		crashed = true
		
