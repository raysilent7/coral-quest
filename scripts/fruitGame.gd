extends Node2D

@onready var button: TextureButton = $fruitButton
@onready var anim: AnimatedSprite2D = $fruitsAnim
@export var fruit: String = "grubble"
@export var speed: float = 60.0

func _ready() -> void:
	anim.play(fruit)
	button.pressed.connect(changeFruit)	

func _process(delta: float) -> void:
	var bonusSpeed: float = GameState.bonusSpeed
	position.y += (speed + bonusSpeed) * delta
	
	if position.y >= 720.0:
		queue_free()

func changeFruit():
	GameState.points -= 1
	queue_free()
