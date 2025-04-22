class_name LevelGenerator extends Node2D


const MAX_SPAWN_ATTEMPT = 50


var ChunkScn = load("res://map/map_chunk.tscn")

@export var chunk_height := 2
@export var chunk_width := 4

const CHUNK_PART_SIZE := 512

@export var entities_per_chunk: int = 10

@export var player: Player
@export var entity_scenes: Array[PackedScene] = []

var min_chunk_idx: int = 0
var max_chunk_idx: int = 0
var chunks: Array[Node2D] = []


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


func generate_chunk() -> void:
	var chunk_idx = max_chunk_idx + 1
	max_chunk_idx = chunk_idx

	var entities_rect: Array[Rect2] = []
	var chunk: MapChunk = ChunkScn.instantiate()
	chunk.chunk_height = chunk_height
	chunk.chunk_width = chunk_width
	add_child(chunk)
	chunks.append(chunk)
	chunk.set_index(chunk_idx)

	for i in entities_per_chunk:
		for _attempt in MAX_SPAWN_ATTEMPT:
			var entity: Entity = get_random_entity()
			entity.position = Vector2(randf_range(0, chunk.width), randf_range(0, chunk.height))
			var rect: Rect2 = get_rect(entity)

			if not chunk.rect.encloses(rect):
				continue
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
	if -player.position.y > (min_chunk_idx + 2) * (chunk_height * CHUNK_PART_SIZE):
		remove_chunk()
	
	if -player.position.y > (max_chunk_idx - 1) * (chunk_height * CHUNK_PART_SIZE):
		generate_chunk()
		
