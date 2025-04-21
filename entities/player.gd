class_name Player extends CharacterBody2D


@export var speed: float = 400
@export var rotation_speed: float = 2.0

@export var power_label: Label

var power: int = 1:
	set(x):
		power = x
		power_label.text = "Power : " + str(power)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("right"):
		rotation += rotation_speed * delta
	elif Input.is_action_pressed("left"):
		rotation -= rotation_speed * delta

	velocity = speed * Vector2.from_angle(rotation - PI / 2)
	move_and_slide()


func _on_eatting_zone_body_entered(body: Node2D) -> void:
	if body is not Zombie:
		return
	
	body.queue_free()
	power += 1
