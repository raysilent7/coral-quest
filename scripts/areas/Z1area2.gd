extends Node2D

@onready var player: CharacterBody2D = $diver/diver

func _ready() -> void:
	var spawnPoint = get_node_or_null(GameState.lastSpawnId)
	var fromPortal = GameState.fromPortal

	GameState.isDark = false

	if fromPortal and spawnPoint:
		player.global_position = spawnPoint.global_position
