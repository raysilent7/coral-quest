extends Area2D

@export var speed: float = 80.0
@export var nextScenePath: String = "res://zone1/area2.tscn"

func _ready() -> void:
	body_entered.connect(onBodyEntered)

func _process(delta):
	var bonusSpeed: float = GameState.bonusSpeed
	position.x -= (speed + bonusSpeed) * delta
	
	if position.x == 0:
		queue_free()

func onBodyEntered(body):
	if body is CharacterBody2D:
		GameState.points += 1
		GameState.bonusSpeed = 50
		queue_free()
		print(GameState.points)

		if GameState.points >= 50:
			GameState.beatSecondPuzzle = true
			get_tree().change_scene_to_file(nextScenePath)
			GameState.isInFishingLinesGame = false
