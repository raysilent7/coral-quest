extends Node

func _process(delta: float) -> void:
	verifyEndGameByPollution()

#environment
var lastSpawnId: String = ""
var lastSurfaceScenePath: String = "res://zone1/shipArea.tscn"
var fromPortal: bool = true #padrao TRUE
var isInWater: bool = false #padrao FALSE
var isInsideBubbles: bool = false #padrao FALSE
var oxygenTime: int  = 60
var pollutionValue: int = 85
var totalPollution: int = 95
var pollutionFactor: int = 5
var isDark: bool = false

#inventario
var actionBarTextures: Array = [null, null, null, null, null]
var actionBarNames: Array = ["nada", "nada", "nada", "nada", "nada"]
var selectedItem: String = "starFruit"

#control variables
var executeFirst: bool = true
var executeSecond: bool = true
var executeThird: bool = true
var executeFourth: bool = true

#minigames
var isInFishingLinesGame: bool = false #padrao FALSE
var beatFirstPuzzle: bool = false
var beatSecondPuzzle: bool = false
var beatThirdPuzzle: bool = false
var beatFourthPuzzle: bool = false
var score: int = 0
var lastShrineId: String = ""
var lastMapPath: String = ""
var bonusSpeed: float = 0.0
var gameTime: int = 120

#methods
func setScore(givenScore: int):
	score = givenScore

func addScore(givenScore: int):
	score += givenScore

func subtractScore(givenScore: int):
	score -= givenScore

func getScore() -> int:
	return score

func movePlayer():
	call_deferred("changeScene")

func changeScene():
	get_tree().change_scene_to_file(lastSurfaceScenePath)

func verifyEndGameByPollution():
	if pollutionValue >= 100:
		print("voce perdeu!")
	elif pollutionValue <= 0:
		print("voce venceu!")

func saveActionBarTextures(items: Array):
	actionBarTextures = items.duplicate()

func loadActionBarTextures() -> Array:
	return actionBarTextures

func saveActionBarNames(items: Array):
	actionBarNames = items.duplicate()

func loadActionBarNames() -> Array:
	return actionBarNames
