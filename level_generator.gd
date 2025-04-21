class_name LevelGenerator extends Node2D


const MAX_SPAWN_ATTEMPT = 50


@export var x_min: float = -200
@export var x_max: float = 200

@export var chunck_size: float = 500
@export var entities_per_chunck: int = 10

@export var player: Player
@export var entity_scenes: Array[PackedScene] = []

var min_chunck_idx: int = 0
var max_chunck_idx: int = 0
var chuncks: Array[Node2D] = []


func get_random_entity() -> Entity:
	var entity: Entity = entity_scenes.pick_random().instantiate()
	entity.init(player)
	entity.get_node("Sprite2D").flip_v = randf() > 0.5
	return entity


func get_rect(entity: Entity) -> Rect2:
	var sprite: Sprite2D = entity.get_node("Sprite2D")
	var rect: Rect2 = sprite.get_rect()
	if is_equal_approx(sprite.rotation_degrees, 90):
		rect = Rect2(rect.position.y, rect.position.x, rect.size.y, rect.size.x)
	elif not is_equal_approx(sprite.rotation_degrees, 0):
		print("Rotation not supported: ", sprite.rotation_degrees)
		return Rect2()

	rect.position *= sprite.global_scale
	rect.position += sprite.global_position
	rect.size *= sprite.global_scale

	return rect


func generate_chunck() -> void:
	var chunck_idx = max_chunck_idx + 1
	max_chunck_idx = chunck_idx

	var entities_rect: Array[Rect2] = []
	var chunck_rect = Rect2(x_min, -chunck_idx * chunck_size, x_max - x_min, chunck_size)

	var chunck = Node2D.new()
	add_child(chunck)
	chuncks.append(chunck)

	for i in entities_per_chunck:
		for _attempt in MAX_SPAWN_ATTEMPT:
			var entity: Entity = get_random_entity()
			entity.position = Vector2(randf_range(x_min, x_max), -(chunck_idx - randf()) * chunck_size)
			var rect: Rect2 = get_rect(entity)

			if not chunck_rect.encloses(rect):
				continue

			if entities_rect.any(func(other_rect: Rect2): return rect.intersects(other_rect)):
				continue
			
			entities_rect.append(rect)
			chunck.add_child(entity)
			break


func remove_chunck() -> void:
	var chunck = chuncks.pop_front()
	if chunck == null:
		print("Trying to remove an unexisting chunck")
		return

	min_chunck_idx += 1

	chunck.queue_free()
			

func _ready() -> void:
	for i in range(1):
		generate_chunck()


func _process(_delta: float) -> void:
	if -player.position.y > (min_chunck_idx + 2) * chunck_size:
		remove_chunck()
	
	if -player.position.y > (max_chunck_idx - 1) * chunck_size:
		generate_chunck()
		
