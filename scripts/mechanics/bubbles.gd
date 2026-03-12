extends Area2D

@onready var anim: AnimatedSprite2D = $bubblesAnim

func _ready():
	body_entered.connect(onBodyEntered)
	anim.play("bubbles")

func onBodyEntered(body):
	if body is CharacterBody2D:
		GameState.oxygenTime = 90
