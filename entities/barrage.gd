class_name Barrage extends Entity


func _ready() -> void:
	var cars: Array = get_children().filter(func(child: Node): return child is Police)

	var n_cars = cars.size()
	var rand_idx = randi_range(1, n_cars - 2)

	cars[rand_idx - 1].queue_free()
	cars[rand_idx].queue_free()
	cars[rand_idx + 1].queue_free()
