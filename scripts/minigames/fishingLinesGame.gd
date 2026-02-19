extends Node2D

@export var fishingLineScene: PackedScene
@export var obstacleScene: PackedScene
@export var backgroundScene: PackedScene
@export var nextScenePath: String = "res://zone1/area2.tscn"
@onready var diver: CharacterBody2D = $diver/diver

var popupVictory = preload("res://HUD/genericPopup.tscn")
var spawnInterval: float = 2.0
var timer: float = 0.0
var maxCount: int = 0
var gameEnded: bool = false

func _ready() -> void:
	GameState.points = 0
	nextScenePath = GameState.lastMapPath
	print(GameState.lastMapPath)
	diver.disableCamera()

func _process(delta):
	if gameEnded:
		return

	if GameState.bonusSpeed > 0:
		GameState.bonusSpeed -= delta * 5

	if GameState.points >= 30:
		GameState.beatSecondPuzzle = true
		GameState.isInFishingLinesGame = false
		endGame()
		showPopup()

func spawnRandom():
	var choice = randi_range(0, 1)
	var obj
	
	if choice == 0 or maxCount > 4:
		obj = fishingLineScene.instantiate()
		maxCount = 0
	else:
		obj = obstacleScene.instantiate()
		maxCount += 1

	obj.position = Vector2(1300, randf_range(0, 400))
	add_child(obj)

func spawnBackground():
	var choice = randi_range(0, 3)
	var obj
	
	print("aconteci: spawn alga")
	
	if choice == 0:
		obj = backgroundScene.instantiate()
		obj.z_index = -1
		obj.add_child(Sprite2D.new())
		obj.get_child(0).texture = load("res://objects/islands/mapObjects/big algae dark.png")
	elif choice == 1:
		obj = backgroundScene.instantiate()
		obj.z_index = 2
		obj.add_child(Sprite2D.new())
		obj.get_child(0).texture = load("res://objects/islands/mapObjects/big algae.png")
	else:
		obj = backgroundScene.instantiate()

	obj.position = Vector2(1300, randf_range(700, 900))
	add_child(obj)

func showPopup():
	var popup = popupVictory.instantiate()
	add_child(popup)
	popup.setMessage("Parabens, voce venceu o segundo desafio. Voce está cada vez mais proximo de salvar o arquipelago, mas ainda há muito a fazer, continue sua jornada.")
	popup.setButtonText("OK")

func endGame():
	gameEnded = true
	GameState.isInFishingLinesGame = false
	GameState.isInWater = true
	diver.enableCamera()
	for child in get_children():
		child.queue_free()

func onTimerSpawnTimeout() -> void:
	spawnRandom()

func onTimerBackgroundTimeout() -> void:
	spawnBackground()
