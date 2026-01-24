extends Control

var minigameScenePath: String

func _ready():
	var screenSize = get_viewport_rect().size
	var panelSize = $instructions.size
	$instructions.position = (screenSize - panelSize) / 2

func setup(scenePath: String):
	minigameScenePath = scenePath

func _on_yes_pressed() -> void:
	get_tree().change_scene_to_file(minigameScenePath)
	queue_free()

func _on_no_pressed() -> void:
	queue_free()
