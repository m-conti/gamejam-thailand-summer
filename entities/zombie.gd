class_name Zombie extends Entity

const resource = [
	"res://assets/Player/Idle2.png",
	"res://assets/Player/Idle3.png",
	"res://assets/Player/Idle4.png",
]

func _ready():
	%Sprite2D.texture = load(resource[randi_range(0, len(resource) - 1)])
