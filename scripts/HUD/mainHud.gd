extends Control

@onready var oxygenBar = $oxygen
@onready var pollutionBar = $polution
@onready var oxygenTimer = $oxygenTimer
@onready var pollutionTimer = $polutionTimer

func _ready():
	oxygenTimer.timeout.connect(onOxygenTimerTimeout)
	pollutionTimer.timeout.connect(onPollutionTimerTimeout)

func _process(delta: float) -> void:
	updatePollution()

func onPollutionTimerTimeout():
	if GameState.pollutionValue <= GameState.totalPollution:
		GameState.pollutionValue += GameState.pollutionFactor
		pollutionBar.value = GameState.pollutionValue

func updatePollution():	
	if GameState.beatFirstPuzzle and GameState.executeFirst:
		GameState.totalPollution = 71
		GameState.pollutionValue -= 25
		pollutionBar.value = GameState.pollutionValue
		GameState.executeFirst = false
		GameState.pollutionFactor = 4
	if GameState.beatSecondPuzzle and GameState.executeSecond:
		GameState.totalPollution = 47
		GameState.pollutionValue -= 25
		pollutionBar.value = GameState.pollutionValue
		GameState.executeSecond = false
		GameState.pollutionFactor = 3
	if GameState.beatThirdPuzzle and GameState.executeThird:
		GameState.totalPollution = 23
		if GameState.pollutionValue < 40:
			GameState.pollutionValue = 15
		else:
			GameState.pollutionValue -= 25
		pollutionBar.value = GameState.pollutionValue
		GameState.executeThird = false
		GameState.pollutionFactor = 2
	if GameState.beatFourthPuzzle and GameState.executeFourth:
		GameState.totallPolution = 0
		pollutionBar.value = GameState.pollutionValue
		GameState.executeFourth = false
		GameState.updateFourth = false
		GameState.pollutionFactor = 0

func onOxygenTimerTimeout():
	if GameState.isInWater and GameState.oxygenTime > 0:
		GameState.oxygenTime -= 1
	elif not GameState.isInWater and GameState.oxygenTime < 90:
		GameState.oxygenTime += 1

	oxygenBar.value = GameState.oxygenTime
	updateOxygenBarColor()

	if GameState.oxygenTime <= 0:
		print("voce morreu!")

func updateOxygenBarColor():
	var styleOxygen = oxygenBar.get_theme_stylebox("fill")
	if styleOxygen == null:
		styleOxygen = StyleBoxFlat.new()
		oxygenBar.add_theme_stylebox_override("fill", styleOxygen)
	styleOxygen.bg_color = Color(0, 1, 0)

func refillOxygen():
	GameState.oxygenTime += 90
	oxygenBar.value = GameState.oxygenTime
