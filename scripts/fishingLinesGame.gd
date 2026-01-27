extends Node2D

@export var fishingLineScene: PackedScene
@export var obstacleScene: PackedScene
@export var nextScenePath: String = "res://zone1/area2.tscn"

var popupVictory = preload("res://objects/popups/genericPopup.tscn")
var spawnInterval: float = 2.0
var timer: float = 0.0
var maxCount: int = 0
var gameEnded: bool = false

func _process(delta):
	if gameEnded:
		return
	
	timer += delta
	if timer >= spawnInterval:
		timer = 0
		spawnRandom()

	if GameState.bonusSpeed > 0:
		GameState.bonusSpeed -= delta * 5

	if GameState.points >= 1:
		GameState.beatSecondPuzzle = true
		GameState.isInFishingLinesGame = false
		endGame()
		showPopup()

func spawnRandom():
	var choice = randi() % 2
	var obj
	
	if choice == 0 or maxCount > 4:
		obj = fishingLineScene.instantiate()
		maxCount = 0
	else:
		obj = obstacleScene.instantiate()
		maxCount += 1

	obj.position = Vector2(1200, randf_range(0, 400))
	add_child(obj)

func showPopup():
	var popup = popupVictory.instantiate()
	add_child(popup)
	popup.setMessage("Parabens, voce venceu o segundo desafio. Voce está cada vez mais proximo de salvar o arquipelago, mas ainda há muito a fazer, continue sua jornada.")
	popup.setButtonText("OK")
	popup.setButtonAction(
		func():
			get_tree().change_scene_to_file(nextScenePath)
	)

func endGame():
	gameEnded = true
	for child in get_children():
		child.queue_free()
