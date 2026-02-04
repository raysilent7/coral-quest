extends Area2D

@export var nextScenePath: String
@export var spawnId: String

func _ready():
	body_entered.connect(onBodyEntered)

func onBodyEntered(body):
	if body is CharacterBody2D:
		GameState.lastSpawnId = spawnId
		GameState.fromPortal = true
		call_deferred("changeScene")

func changeScene():
	get_tree().change_scene_to_file(nextScenePath)
