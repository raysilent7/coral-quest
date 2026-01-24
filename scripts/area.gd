extends Node2D


func _ready() -> void:
	var player = $diver/diver
	var spawnPoint = get_node_or_null(GameState.lastSpawnId)
	var shrinePoint = get_node_or_null(GameState.lastShrineId)
	var fromPortal = GameState.fromPortal
	if fromPortal and spawnPoint:
		player.global_position = spawnPoint.global_position
	elif shrinePoint:
		player.global_position = shrinePoint.global_positiond
