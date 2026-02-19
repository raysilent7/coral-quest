extends Node2D

const boardWidth = 10
const boardHeight = 20
const blockSize = 32

var board = []
var points = 0

func _ready():
	var screenSize = get_viewport_rect().size
	
	position.x = (screenSize.x - boardWidth * blockSize) / 2
	position.y = 100
	board.resize(boardHeight)
	
	for y in range(boardHeight):
		board[y] = []
		board[y].resize(boardWidth)
		for x in range(boardWidth):
			board[y][x] = null

func fixPiece(piece: Node2D):
	# grava os blocos da peça atual na matriz
	for block in piece.get_children():
		var pos = (piece.position / blockSize) + (block.position / blockSize)
		var x = int(pos.x)
		var y = int(pos.y)

		if y >= 0 and y < boardHeight and x >= 0 and x < boardWidth:
			board[y][x] = block

	checkLines()

func checkLines():
	for y in range(boardHeight):
		var full = true
		for x in range(boardWidth):
			if board[y][x] == null:
				full = false
				break

		if full:
			clearLine(y)
			addPoints()

func clearLine(lineIndex: int):
	# 1. Remove os blocos da linha apagada
	for x in range(boardWidth):
		if board[lineIndex][x] != null:
			board[lineIndex][x].queue_free()
			board[lineIndex][x] = null

	# 2. Move os blocos acima para baixo
	for y in range(lineIndex, 0, -1):
		for x in range(boardWidth):
			board[y][x] = board[y - 1][x]
			if board[y][x] != null:
				board[y][x].position.y += blockSize

	# 3. Limpa o topo
	for x in range(boardWidth):
		board[0][x] = null


func addPoints():
	GameState.points += 100
	print("Pontuação: ", GameState.points)
