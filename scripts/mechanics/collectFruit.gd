extends Area2D

@onready var label: Label = $pressE
@export var icon: Texture2D = preload("res://objects/fruits/star fruit.png")


var playerInside: bool = false

func _ready():
	body_entered.connect(onBodyEntered)
	body_exited.connect(onBodyExited)

func _process(delta):
	if playerInside and Input.is_action_just_pressed("interact"):
		var actionBar = get_tree().root.get_node("area4/CanvasLayer/mainHud/actionBar")
		actionBar.addItem(icon, "starFruit")
		queue_free()

func onBodyEntered(body):
	if body is CharacterBody2D:
		playerInside = true
		label.visible = true

func onBodyExited(body):
	if body is CharacterBody2D:
		playerInside = false
		label.visible = false
