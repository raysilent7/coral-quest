extends Node2D

@onready var player: CharacterBody2D = $diver/diver
@onready var waterLevel: Marker2D = $waterLevel

func _ready() -> void:
	var spawnPoint = get_node_or_null(GameState.lastSpawnId)
	var fromPortal = GameState.fromPortal

	GameState.isDark = false

	if fromPortal and spawnPoint:
		player.global_position = spawnPoint.global_position

func _process(delta: float) -> void:
	if player is CharacterBody2D and player.global_position.y > waterLevel.global_position.y:
		GameState.isInWater = true
	else:
		GameState.isInWater = false
