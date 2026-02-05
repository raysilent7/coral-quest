extends Control

@onready var oxygenBar = $oxygen
@onready var polutionBar = $polution
@onready var oxygenTimer = $oxygenTimer

func _ready():
	oxygenTimer.timeout.connect(onOxygenTimerTimeout)
	oxygenBar.min_value = 0
	oxygenBar.max_value = 90
	oxygenBar.value = GameState.oxygenTime


func onOxygenTimerTimeout():
	if GameState.isInWater and GameState.oxygenTime > 0:
		GameState.oxygenTime -= 1
	elif not GameState.isInWater and GameState.oxygenTime < 90:
		GameState.oxygenTime += 1

	print(GameState.oxygenTime)
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
		style.bg_color = Color(0, 1, 0) # verde
	elif value > 30:
		style.bg_color = Color(1, 1, 0) # amarelo
	else:
		style.bg_color = Color(1, 0, 0) # vermelho
