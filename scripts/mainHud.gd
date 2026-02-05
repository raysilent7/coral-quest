extends Control

@onready var oxygenBar = $oxygen
@onready var polutionBar = $polution
@onready var oxygenTimer = $oxygenTimer
@onready var polutionTimer = $polutionTimer

func _ready():
	oxygenTimer.timeout.connect(onOxygenTimerTimeout)
	polutionTimer.timeout.connect(onPolutionTimerTimeout)

func _process(delta: float) -> void:
	updatePolution()

func onPolutionTimerTimeout():
	if GameState.polutionValue <= GameState.totalPolution:
		GameState.polutionValue += GameState.polutionFactor

func updatePolution():	
	if GameState.beatFirstPuzzle and GameState.executeFirst:
		GameState.totalPolution = 71
		GameState.polutionValue -= 25
		polutionBar.value = GameState.polutionValue
		GameState.executeFirst = false
		GameState.polutionFactor = 4
	if GameState.beatSecondPuzzle and GameState.executeSecond:
		GameState.totalPolution = 47
		GameState.polutionValue -= 25
		polutionBar.value = GameState.polutionValue
		GameState.executeSecond = false
		GameState.polutionFactor = 3
	if GameState.beatThirdPuzzle and GameState.executeThird:
		GameState.totalPolution = 23
		if GameState.polutionValue < 40:
			GameState.polutionValue = 15
		else:
			GameState.polutionValue -= 25
		polutionBar.value = GameState.polutionValue
		GameState.executeThird = false
		GameState.polutionFactor = 2
	if GameState.beatFourthPuzzle and GameState.executeFourth:
		GameState.totalPolution = 0
		polutionBar.value = GameState.polutionValue
		GameState.executeFourth = false
		GameState.updateFourth = false
		GameState.polutionFactor = 0

func onOxygenTimerTimeout():
	if GameState.isInWater and GameState.oxygenTime > 0:
		GameState.oxygenTime -= 1
	elif not GameState.isInWater and GameState.oxygenTime < 90:
		GameState.oxygenTime += 1

	oxygenBar.value = GameState.oxygenTime
	updateBarColor(GameState.oxygenTime)

	if GameState.oxygenTime <= 0:
		print("voce morreu!")

func updateBarColor(value: int):
	var style = oxygenBar.get_theme_stylebox("fill")
	if style == null:
		style = StyleBoxFlat.new()
		oxygenBar.add_theme_stylebox_override("fill", style)

	if value > 60:
		style.bg_color = Color(0, 1, 0)
	elif value > 30:
		style.bg_color = Color(1, 1, 0)
	else:
		style.bg_color = Color(1, 0, 0)
