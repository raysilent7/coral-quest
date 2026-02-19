extends Node2D

@export var speed: float = 80.0

func _process(delta):
	var bonusSpeed: float = GameState.bonusSpeed
	position.x -= (speed + bonusSpeed) * delta
	
	if position.x <= -1290:
		print("morri algae.tscn")
		queue_free()
