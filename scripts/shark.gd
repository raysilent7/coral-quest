extends Area2D

@export var nextScenePath: String = "res://zone1/area2.tscn"
@export var speed: float = 80.0

func _ready() -> void:
	body_entered.connect(onBodyEntered)

func _process(delta: float) -> void:
	var bonusSpeed: float = GameState.bonusSpeed
	position.x -= (speed + bonusSpeed) * delta
	
	if position.x == 0:
		queue_free()

func onBodyEntered(body):
	if body is CharacterBody2D:
		get_tree().change_scene_to_file(nextScenePath)
		GameState.isInFishingLinesGame = false
