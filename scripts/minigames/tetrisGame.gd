extends Node2D

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

	if currentPieceNode.activePiece != null and currentPieceNode.isColliding():
		print("Game Over")
		get_tree().paused = true
