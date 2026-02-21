extends Control

@onready var label: Label = $genericPanel/text
@onready var button: Button = $genericPanel/button

func _ready():
	var screenSize = get_viewport_rect().size
	var panelSize = $genericPanel.size
	$genericPanel.position = (screenSize - panelSize) / 2
	
	label.text = "Parabens! Voce venceu o quebra cabeça. Continue para desvendar mais mistérios do arquipelago e salva-lo da extinção."

func onButtonPressed() -> void:
	get_tree().change_scene_to_file(GameState.lastMapPath)
	queue_free()

func setMessage(text: String):
	label.text = text

func setButtonText(text: String):
	button.text = text
