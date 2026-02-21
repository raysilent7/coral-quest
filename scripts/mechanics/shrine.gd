extends Area2D

@onready var label: Label = $pressE
@export var minigameScenePath: String = "res://minigames/fishingLinesGame.tscn"
@export var shrineId: String

var instructions = preload("res://HUD/instructionsScene.tscn")
var playerInside: bool = false

func _ready():
	body_entered.connect(onBodyEntered)
	body_exited.connect(onBodyExited)

func onBodyEntered(body):
	if body is CharacterBody2D:
		playerInside = true
		label.visible = true

func onBodyExited(body):
	if body is CharacterBody2D:
		playerInside = false
		label.visible = false

func _process(delta):
	if playerInside and Input.is_action_just_pressed("interact"):
		GameState.lastMapPath = get_tree().current_scene.scene_file_path
		GameState.lastShrineId = shrineId
		GameState.fromPortal = false
		
		var popup = instructions.instantiate()
		add_child(popup)
		popup.setMessage(resolveText())
		popup.setTitle(resolveTitle())
		popup.setup(minigameScenePath)

func resolveText() -> String:
	if shrineId == "shrine":
		return "Clique nas cartas com o botão esquerdo do mouse para revela-las e formar pares de cartas iguais. 
		Encontre todos os pares de cartas antes do tempo acabar para vencer o jogo."
	elif shrineId == "shrine2":
		return "Aperte espaço para nadar para cima. Desvie dos tubarões para não ser mordido e corte 30 linhas de pesca ilegal, 
		mas cuidado para não encostar nos anzóis, pois eles são bem afiados."
	elif shrineId == "shrine3":
		return "Clique com o botão esquerdo do mouse em cima de uma fruta para coleta-la e somar pontos, some 50 pontos para vencer, 
		mas cuidado para não acabar clicando no lixo, voce deve deixa-los vair na lixeira, ou perderá pontos!"
	elif shrineId == "shrine4":
		return "Use A e D para mover as peças de um lado a outro, use o Espaço para rotacionar a peça e S para acelerar sua queda. 
		Forme linhas para fazer pontos, ao chegar em 5000 pontos voce vence. Não deixe as peças empilharem até o final da tela ou será fim de jogo."
	else:
		return ""

func resolveTitle() -> String:
	if shrineId == "shrine":
		return "Jogo da memória"
	elif shrineId == "shrine2":
		return "Corte as linhas de pesca"
	elif shrineId == "shrine3":
		return "Salada de frutas"
	elif shrineId == "shrine4":
		return "Tetris das joias"
	else:
		return ""
