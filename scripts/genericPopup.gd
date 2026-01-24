extends Control

@onready var label: Label = $genericPanel/text

func _ready():
	var screenSize = get_viewport_rect().size
	var panelSize = $genericPanel.size
	$genericPanel.position = (screenSize - panelSize) / 2
	
	label.text = "Parabens! Voce venceu o primeiro quebra cabeça. Continue para desvendar mais mistérios do arquipelago e salva-lo da extinção."

func _on_ok_pressed() -> void:
	get_tree().change_scene_to_file(GameState.lastMapPath)
	queue_free()
