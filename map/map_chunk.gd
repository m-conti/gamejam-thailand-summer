class_name MapChunk extends Node2D

@export var chunk_height := 2
@export var chunk_width := 4

const CHUNK_PART_SIZE := 512

var height:
	get: return float(chunk_height * CHUNK_PART_SIZE)

var width:
	get: return float(chunk_width * CHUNK_PART_SIZE)

var size:
	get: return Vector2(width, height)

var rect:
	get: return Rect2(0, 0, self.width, self.height)

func _ready():
	for j in range(chunk_height):
		for i in range(chunk_width):
			%TileMapLayer.set_cell(Vector2(i, j), 1, Vector2(0 if randi_range(0, 3) != 0 else randi_range(0, 8), 0))
		%TileMapLayer.set_cell(Vector2(0, j), 2, Vector2(0, 0))
		%TileMapLayer.set_cell(Vector2(chunk_width - 1, j), 2, Vector2(1, 0))

func set_index(index: int):
	self.position = Vector2(-self.width / 2, index * -self.height)
