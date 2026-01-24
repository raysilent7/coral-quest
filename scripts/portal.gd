extends Area2D

@export var nextScenePath: String = "res://zone1/area2.tscn"
@export var spawnId: String

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		GameState.lastSpawnId = spawnId
		call_deferred("changeScene")

func changeScene():
	get_tree().change_scene_to_file(nextScenePath)
