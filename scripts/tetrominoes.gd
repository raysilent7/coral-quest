extends Node2D

const blockSize = 32

var textures = [
	preload("res://objects/tetris/blue block.png"),
	preload("res://objects/tetris/green block.png"),
	preload("res://objects/tetris/pink block.png"),
	preload("res://objects/tetris/red block.png")
]

var shape = []

func setup(shapeData: Array):
	shape = shapeData

	for child in get_children():
		child.queue_free()

	var chosenTexture = textures[randi() % textures.size()]

	for offset in shape:
		var block = Sprite2D.new()
		block.texture = chosenTexture
		block.position = offset * blockSize
		add_child(block)
