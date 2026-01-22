extends Node2D

@onready var button: TextureButton = $cardButton
@onready var anim: AnimatedSprite2D = $animations
@export var flipAnimation: String = "flipDefault"
@export var unflipAnimation: String = "unflipDefault"
var isFlipped: bool = false

func _ready() -> void:
	button.pressed.connect(revealCard)

func revealCard():
	if not isFlipped and get_parent().canClick:
		anim.play(flipAnimation)
		get_parent().onCardRevealed(self)
		isFlipped = true

func playUnflipAnimation():
	if isFlipped:
		anim.play(unflipAnimation)
		isFlipped = false
