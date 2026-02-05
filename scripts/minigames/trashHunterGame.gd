extends Node2D

@export var trashScene: PackedScene
@export var fruitScene: PackedScene
@export var nextScenePath: String = "res://zone1/area2.tscn"

var popupVictory = preload("res://objects/popups/genericPopup.tscn")
var spawnInterval: float = 1.0
var timer: float = 0.0
var maxCount: int = 0
var gameEnded: bool = false
var fruits = ["grubble", "nababa", "star", "kiko"]
var trashs = ["bottle", "can", "hook", "straw"]

func _ready() -> void:
	GameState.points = 0

func _process(delta: float) -> void:
	if gameEnded:
		return

	timer += delta
	if timer >= spawnInterval:
		timer = 0
		spawnRandom()
		spawnRandom()

	GameState.bonusSpeed += delta * 5

	if GameState.points >= 50:
		GameState.beatThirdPuzzle = true
		endGame()
		showPopup()

func spawnRandom():
	var choice = randi_range(0, 1)
	var animChoice = randi_range(0, 3)
	var obj
	
	if choice == 0 or maxCount > 4:
		obj = trashScene.instantiate()
		obj.trash = trashs[animChoice]
		maxCount = 0
	else:
		obj = fruitScene.instantiate()
		obj.fruit = fruits[animChoice]
		maxCount += 1

	obj.position = Vector2(randf_range(300, 900), randf_range(-100, 0))
	add_child(obj)

func showPopup():
	var popup = popupVictory.instantiate()
	add_child(popup)
	popup.setMessage("Parabens voce venceu")
	popup.setButtonText("OK")
	popup.setButtonAction(
		func():
			get_tree().change_scene_to_file(nextScenePath)
	)

func endGame():
	gameEnded = true
	for child in get_children():
		child.queue_free()
