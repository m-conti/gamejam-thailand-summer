class_name LevelGenerator extends Node2D


const MAX_SPAWN_ATTEMPT = 50


const chunkScn = preload("res://map/map_chunk.tscn")

@export var chunk_height := 2
@export var chunk_width := 4
@export var preload_chunk := 4
@export var unload_chunk := 2

const CHUNK_PART_SIZE := 512

@export var entities_per_chunk: int = 10

@export var player: Player
@export var entity_scenes: Dictionary[PackedScene, int] = {}

var min_chunk_idx: int = 0
var max_chunk_idx: int = 0
var chunks: Array[Node2D] = []


func pick_from_proba_dist(proba_dist: Dictionary) -> Variant:
	var total: float = 0
	for value in proba_dist.values():
		total += value

	var rand: float = randf() * total
	for key in proba_dist.keys():
		rand -= proba_dist[key]
		if rand <= 0:
			return key

	return null


func difficulty_to_proba(chunk_idx: int, difficulty: int) -> float:
	if chunk_idx <= 8:
		return [0.9, 0.1, 0.0][difficulty]
	elif chunk_idx <= 64:
		return [0.7, 0.2, 0.1][difficulty]
	elif chunk_idx <= 256:
		return [0.4, 0.4, 0.2][difficulty]
	elif chunk_idx <= 1024:
		return [0.2, 0.5, 0.3][difficulty]
	else:
		return [0.0, 0.6, 0.4][difficulty]


func get_random_entity(proba_dist: Dictionary) -> Entity:
	var entity: Entity = pick_from_proba_dist(proba_dist).instantiate()
	entity.init(player)
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
	rect.size *= sprite.global_scale
	return rect


func generate_chunk() -> void:
	var chunk_idx = max_chunk_idx + 1
	max_chunk_idx = chunk_idx

	var proba_dist: Dictionary = {}
	for entity in entity_scenes:
		proba_dist[entity] = difficulty_to_proba(chunk_idx, entity_scenes[entity])

	var entities_rect: Array[Rect2] = []
	var chunk: MapChunk = chunkScn.instantiate()
	chunk.chunk_height = chunk_height
	chunk.chunk_width = chunk_width
	add_child(chunk)
	chunks.append(chunk)
	chunk.set_index(chunk_idx)

	for i in entities_per_chunk:
		for _attempt in MAX_SPAWN_ATTEMPT:
			var entity: Entity = get_random_entity(proba_dist)
			var rect: Rect2 = get_rect(entity)
			entity.position = Vector2(randf_range(0, chunk.width - rect.size.x), randf_range(0, chunk.height - rect.size.y))
			rect.position += entity.global_position
			entity.position += rect.size / 2

			if entities_rect.any(func(other_rect: Rect2): return rect.intersects(other_rect)):
				continue

			entities_rect.append(rect)
			chunk.add_child(entity)
			break


func remove_chunk() -> void:
	var chunk = chunks.pop_front()
	if chunk == null:
		print("Trying to remove an unexisting chunk")
		return

	min_chunk_idx += 1

	chunk.queue_free()
			

func _ready() -> void:
	for i in range(1):
		generate_chunk()


func _process(_delta: float) -> void:
	if -player.position.y > (min_chunk_idx + preload_chunk) * (chunk_height * CHUNK_PART_SIZE):
		remove_chunk()
	
	if -player.position.y > (max_chunk_idx - unload_chunk) * (chunk_height * CHUNK_PART_SIZE):
		generate_chunk()
		
