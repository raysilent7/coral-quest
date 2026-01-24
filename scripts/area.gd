extends Node2D


func _ready() -> void:
	var player = $diver/diver
	var spawnPoint = get_node_or_null(GameState.lastSpawnId)
	if spawnPoint:
		player.global_position = spawnPoint.global_position
