extends Node2D

@onready var button: TextureButton = $trashButton
@onready var anim: AnimatedSprite2D = $trashCan
@export var trash: String = "can"
const speed: float = 60.0
const maxSpeed: float = 200.0

func _ready() -> void:
	anim.play(trash)
	button.pressed.connect(changeTrash)

func _process(delta: float) -> void:
	var actualSpeed = (speed + GameState.bonusSpeed) * delta
	position.y += min(actualSpeed, maxSpeed)
	
	if position.y >= 500.0:
		queue_free()

func changeTrash():
	GameState.subtractScore(1)
	queue_free()
