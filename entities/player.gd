class_name Player extends RigidBody2D


signal collided(entity: Entity)


@export var base_speed: float = 500
@export var max_speed: float = 1500
@export var max_distance: float = 50_000.0

@export var rotation_speed: float = 2.0

@export var life_label: Label

@onready var eating_zone: Area2D = %EatingZone

var power: Power

var distance:
	get: return self.owner.distance

var speed:
	get: return min(base_speed + (1 - (max_distance - distance) / max_distance) * (max_speed - base_speed), max_speed)

@export var life: int = 1:
	set(x):
		if x <= 0:
			die()
			return

		life = x
		if life_label:
			life_label.text = "Life : " + str(life)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("right"):
		rotation += rotation_speed * delta
	elif Input.is_action_pressed("left"):
		rotation -= rotation_speed * delta

	linear_velocity = speed * Vector2.from_angle(rotation - PI / 2)


func _on_eating_zone_body_entered(body: Node2D) -> void:
	if body is not Zombie and body is not PoliceMan:
		return
	
	%BiteStreamPlayer.play()
	body.queue_free()
	life += 1


func die():
	get_tree().change_scene_to_file.call_deferred("res://game_over.tscn")


func shooted():
	%ShotedStreamPlayer.play()
	life -= 1

func _on_collided(_entity) -> void:
	%CollisionStreamPlayer.play()
	life -= 1


func _on_radio_channel_changed(current: RadioChannel) -> void:
	assert(current.power != null, "The channel " + str(current.display_name) + " needs a power script")
	Power.add(current.power, self)
