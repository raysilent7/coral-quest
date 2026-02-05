extends Node

#environment
var lastSpawnId: String = ""
var lastMapPath: String = ""
var fromPortal: bool = true #padrao TRUE
var isInWater: bool = false #padrao FALSE
var oxygenTime: int  = 90
var polutionValue: int = 85
var totalPolution: int = 95
var polutionFactor: int = 5

#control variables
var executeFirst: bool = true
var executeSecond: bool = true
var executeThird: bool = true
var executeFourth: bool = true

#minigames
var isInFishingLinesGame: bool = false #padrao FALSE
var beatFirstPuzzle: bool = true
var beatSecondPuzzle: bool = false
var beatThirdPuzzle: bool = false
var beatFourthPuzzle: bool = false
var points: int = 0
var lastShrineId: String = ""
var bonusSpeed: float = 0.0
