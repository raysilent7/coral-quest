extends Area2D

@export var nextScenePath: String = "res://zone1/area2.tscn"

func _ready() -> void:
	body_entered.connect(onBodyEntered)

func onBodyEntered(body):
	if body is CharacterBody2D:
		get_tree().change_scene_to_file(nextScenePath)
		GameState.isInFishingLinesGame = false
