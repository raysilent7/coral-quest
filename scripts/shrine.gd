extends Area2D

@onready var label: Label = $pressE
@export var instructionsScene: PackedScene
@export var minigameScenePath: String = "res://minigames/memoryGame.tscn"
@export var shrineId: String

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
		
		var popup = instructionsScene.instantiate()
		get_tree().root.add_child(popup)
		popup.setup(minigameScenePath)
