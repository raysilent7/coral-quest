extends Node2D

@export var fishingLineScene: PackedScene
@export var obstacleScene: PackedScene
@export var spawnInterval: float = 2.0

var timer: float = 0.0
var maxCount: int = 0

func _process(delta):
	timer += delta
	if timer >= spawnInterval:
		timer = 0
		spawnRandom()

	if GameState.bonusSpeed > 0:
		GameState.bonusSpeed -= delta * 5

func spawnRandom():
	var choice = randi() % 2
	var obj
	
	if choice == 0 or maxCount > 4:
		obj = fishingLineScene.instantiate()
		maxCount = 0
	else:
		obj = obstacleScene.instantiate()
		maxCount += 1

	obj.position = Vector2(1200, randf_range(0, 400))
	add_child(obj)
