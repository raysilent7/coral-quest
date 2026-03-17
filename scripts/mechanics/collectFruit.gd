extends Area2D

@onready var label: Label = $pressE
@export var fruitName: String = ""
var starFruitIcon: Texture2D = preload("res://objects/fruits/star fruit.png")
var grubbleFruitIcon: Texture2D = preload("res://objects/fruits/grubble fruit.png")
var nababaFruitIcon: Texture2D = preload("res://objects/fruits/nababa fruit.png")
var kikoFruitIcon: Texture2D = preload("res://objects/fruits/kiko fruit.png")
var playerInside: bool = false

func _ready():
	body_entered.connect(onBodyEntered)
	body_exited.connect(onBodyExited)

func _process(delta):
	if playerInside and Input.is_action_just_pressed("interact"):
		var actionBar = get_tree().current_scene.get_node("CanvasLayer/mainHud/actionBar")
		actionBar.addItem(resolveFruitIcon(), fruitName)
		queue_free()

func onBodyEntered(body):
	if body is CharacterBody2D:
		playerInside = true
		label.visible = true

func onBodyExited(body):
	if body is CharacterBody2D:
		playerInside = false
		label.visible = false

func resolveFruitIcon() -> Texture2D:
	if fruitName == "starFruit":
		return starFruitIcon
	elif fruitName == "grubbleFruit":
		return grubbleFruitIcon
	elif fruitName == "nababaFruit":
		return nababaFruitIcon
	else:
		return kikoFruitIcon
