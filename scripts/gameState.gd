extends Node

var lastSpawnId: String = ""
var lastMapPath: String = ""
var lastShrineId: String = ""
var fromPortal: bool = true #padrao TRUE
var isInWater: bool = false #padrao FALSE
var isInFishingLinesGame: bool = false #padrao FALSE
var points: int = 0
var bonusSpeed: float = 0.0

var beatFirstPuzzle: bool = true
var beatSecondPuzzle: bool = false
var beatThirdPuzzle: bool = false
 
