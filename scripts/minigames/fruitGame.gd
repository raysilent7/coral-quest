extends Node2D

@onready var button: TextureButton = $fruitButton
@onready var anim: AnimatedSprite2D = $fruitsAnim
@export var fruit: String = "grubble"

const speed: float = 60.0
const maxSpeed: float = 300.0

func _ready() -> void:
	anim.play(fruit)
	button.pressed.connect(changeFruit)	

func _process(delta: float) -> void:
	var bonusSpeed = GameState.bonusSpeed
	var actualSpeed = (speed + bonusSpeed) * delta
	position.y += min(actualSpeed, maxSpeed)
	
	if position.y >= 500.0:
		GameState.subtractScore(1)
		queue_free()

func changeFruit():
	GameState.addScore(1)
	queue_free()
