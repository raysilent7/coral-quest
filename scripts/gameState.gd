extends Node

func _process(delta: float) -> void:
	verifyEndGame()

#environment
var lastSpawnId: String = ""
var fromPortal: bool = true #padrao TRUE
var isInWater: bool = false #padrao FALSE
var oxygenTime: int  = 90
var pollutionValue: int = 85
var totalPollution: int = 95
var pollutionFactor: int = 5
var isDark: bool = false

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
var points: int = 0
var lastShrineId: String = ""
var lastMapPath: String = ""
var bonusSpeed: float = 0.0
var gameTime: int = 120

#inventory
var selectedItem: String = "nothing"
var inventory = {
	"1": "nothing",
	"2": "nothing",
	"3": "nothing",
	"4": "nothing",
	"5": "nothing"
}

func verifyEndGame():
	if pollutionValue >= 100:
		print("voce perdeu!")
	elif pollutionValue <= 0:
		print("voce venceu!")
