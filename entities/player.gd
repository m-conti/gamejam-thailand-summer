class_name Player extends CharacterBody2D


@export var speed: float = 400
@export var rotation_speed: float = 2.0

func _physics_process(delta: float) -> void:
	position += speed * delta * Vector2.from_angle(rotation - PI / 2)

	if Input.is_action_pressed("right"):
		rotation += rotation_speed * delta
	elif Input.is_action_pressed("left"):
		rotation -= rotation_speed * delta