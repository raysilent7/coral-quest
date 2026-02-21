extends Node2D

@export var trashScene: PackedScene
@export var fruitScene: PackedScene
@export var genericScene: PackedScene
@export var nextScenePath: String = "res://zone1/area2.tscn"
@onready var timerLabel: Label = $time
@onready var scoreLabel: Label = $score

var maxCount: int = 0
var fruits = ["grubble", "nababa", "star", "kiko"]
var trashs = ["bottle", "can", "hook", "straw"]

func _ready() -> void:
	GameState.setScore(0)

func _process(delta: float) -> void:
	scoreLabel.text = str(GameState.getScore())
	GameState.bonusSpeed += delta * 5

	if GameState.getScore() >= 50:
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

	obj.position = Vector2(randf_range(350, 950), randf_range(-100, 0))
	add_child(obj)

func showPopup():
	var popup = genericScene.instantiate()
	get_tree().root.add_child(popup)
	popup.setMessage("Voce recolheu bastante lixo da praia, os nativos te adoram! Continue sua aventura, pois ainda há muito a fazer para salvar o arquipelago.")
	popup.setButtonText("OK")

func endGame():
	GameState.beatThirdPuzzle = true
	get_tree().set_pause(true)
	for child in get_children():
		child.queue_free()

func onTimerGameTimeout() -> void:
	GameState.gameTime -= 1
	timerLabel.text = str(GameState.gameTime/60)+":"+str(GameState.gameTime%60)
	if GameState.gameTime == 0:
		GameState.beatThirdPuzzle = false
		GameState.setScore(0)
		get_tree().set_pause(true)
		var popup = genericScene.instantiate()
		get_tree().root.add_child(popup)
		popup.setMessage("Não foi dessa vez, tente novamente.")

func onTimerSpawnTimeout() -> void:
	spawnRandom()
	spawnRandom()
