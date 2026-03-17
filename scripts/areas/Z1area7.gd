extends Node2D

@onready var player: CharacterBody2D = $diver/diver
@onready var waterLevel: Marker2D = $waterLevel

func _ready() -> void:
	var spawnPoint = get_node_or_null(GameState.lastSpawnId)
	var shrinePoint = get_node_or_null(GameState.lastShrineId)
	var fromPortal = GameState.fromPortal

	get_tree().set_pause(false)
	GameState.isDark = true

	if fromPortal and spawnPoint:
		player.global_position = spawnPoint.global_position
	elif not fromPortal and shrinePoint:
		player.global_position = shrinePoint.global_position

func _process(delta: float) -> void:
	if player is CharacterBody2D and player.global_position.y > waterLevel.global_position.y:
		GameState.isInWater = true
	else:
		GameState.isInWater = false
