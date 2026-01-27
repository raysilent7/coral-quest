extends Node

var lastSpawnId: String = ""
var lastMapPath: String = ""
var lastShrineId: String = ""
var fromPortal: bool = true
var isInWater: bool = false
var isInFishingLinesGame: bool = true
var points: int = 0
var bonusSpeed: float = 0.0

var beatFirstPuzzle: bool = false
var beatSecondPuzzle: bool = false
