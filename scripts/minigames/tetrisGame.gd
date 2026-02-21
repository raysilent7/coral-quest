extends Node2D

@export var genericScene: PackedScene
@onready var board = $board
@onready var currentPieceNode = $board/currentPiece

const blockSize = 32
const boardWidth = 10
const boardHeight = 20

var pieceScene = preload("res://objects/tetris/tetrominoes.tscn")
var tetrominoes = {
	"I": [Vector2(0,0), Vector2(1,0), Vector2(2,0), Vector2(3,0)],
	"O": [Vector2(0,0), Vector2(1,0), Vector2(0,1), Vector2(1,1)],
	"T": [Vector2(1,0), Vector2(0,1), Vector2(1,1), Vector2(2,1)],
	"J": [Vector2(0,0), Vector2(0,1), Vector2(1,1), Vector2(2,1)],
	"L": [Vector2(2,0), Vector2(0,1), Vector2(1,1), Vector2(2,1)],
	"S": [Vector2(1,0), Vector2(2,0), Vector2(0,1), Vector2(1,1)],
	"Z": [Vector2(0,0), Vector2(1,0), Vector2(1,1), Vector2(2,1)]
}

func _ready():
	spawnNewPiece()

func spawnNewPiece():
	var keys = tetrominoes.keys()
	var randomKey = keys[randi() % keys.size()]
	var shape = tetrominoes[randomKey]
	var piece = pieceScene.instantiate()
	var spawnX = int(board.boardWidth / 2)
	
	piece.position = Vector2(spawnX, 0) * blockSize
	piece.setup(shape)
	currentPieceNode.setActivePiece(piece)
	checkCollision()

func checkCollision():
	if currentPieceNode.activePiece != null and currentPieceNode.isColliding():
		print("Game Over")
		GameState.beatFourthPuzzle = false
		GameState.setScore(0)
		get_tree().set_pause(true)
		var popup = genericScene.instantiate()
		get_tree().root.add_child(popup)
		popup.setMessage("Não foi dessa vez, tente novamente.")

func showPopup():
	var popup = genericScene.instantiate()
	get_tree().root.add_child(popup)
	popup.setMessage("Parabens, voce conquistou o maior tesouro dos sete mares, voce salvou todo arquipelago de ser extinto! 
	Converse com os nativos sobre seus feitos, eles com certeza vão te agradecer muito.")
	popup.setButtonText("OK")

func endGame():
	GameState.beatFourthPuzzle = true
	get_tree().set_pause(true)
	for child in get_children():
		child.queue_free()
