extends Node

#environment
var lastSpawnId: String = ""
var lastMapPath: String = ""
var fromPortal: bool = true #padrao TRUE
var isInWater: bool = false #padrao FALSE
var oxygenTime: int  = 90
var polutionTime: int = 100

#minigames
var isInFishingLinesGame: bool = false #padrao FALSE
var beatFirstPuzzle: bool = true
var beatSecondPuzzle: bool = false
var beatThirdPuzzle: bool = false
var points: int = 0
var lastShrineId: String = ""
var bonusSpeed: float = 0.0
