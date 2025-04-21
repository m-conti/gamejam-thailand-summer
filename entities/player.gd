class_name Player extends RigidBody2D


@export var speed: float = 400
@export var rotation_speed: float = 2.0

@export var power_label: Label

@export var power: int = 1:
	set(x):
		if x <= 0:
			die()
			return

		power = x
		if power_label:
			power_label.text = "Power : " + str(power)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("right"):
		rotation += rotation_speed * delta
	elif Input.is_action_pressed("left"):
		rotation -= rotation_speed * delta

	linear_velocity = speed * Vector2.from_angle(rotation - PI / 2)


func _on_eatting_zone_body_entered(body: Node2D) -> void:
	if body is not Zombie:
		return
	
	body.queue_free()
	power += 1


func die():
	get_tree().change_scene_to_file.call_deferred("res://game_over.tscn")
