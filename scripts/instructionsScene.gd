extends Control

@onready var label: Label = $CanvasLayer/instructions/content
@onready var label2: Label = $CanvasLayer/instructions/title
var minigameScenePath: String

func _ready():
	var screenSize = get_viewport_rect().size
	var panelSize = $CanvasLayer/instructions.size
	$CanvasLayer/instructions.position = (screenSize - panelSize) / 2
	print(label)
	print(label2)

func setup(scenePath: String):
	minigameScenePath = scenePath

func _on_yes_pressed() -> void:
	GameState.isInFishingLinesGame = true
	GameState.isInWater = false
	get_tree().change_scene_to_file(minigameScenePath)
	queue_free()

func _on_no_pressed() -> void:
	queue_free()

func setMessage(text: String):
	label.text = text

func setTitle(text: String):
	label2.text = text
