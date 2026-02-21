extends Area2D

const pos = Vector2(0.0, 0.0)

func _ready():
	body_entered.connect(onBodyEntered)

func onBodyEntered(body):
	if body is CharacterBody2D:
		body.position = pos
