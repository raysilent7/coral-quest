extends Node2D

@onready var button: TextureButton = $trashButton
@onready var anim: AnimatedSprite2D = $trashCan
@export var trash: String = "can"
@export var speed: float = 60.0

func _ready() -> void:
	anim.play(trash)
	button.pressed.connect(changeTrash)

func _process(delta: float) -> void:
	var bonusSpeed: float = GameState.bonusSpeed
	position.y += (speed + bonusSpeed) * delta
	
	if position.y >= 500.0:
		queue_free()

func changeTrash():
	GameState.points -= 1
	queue_free()
