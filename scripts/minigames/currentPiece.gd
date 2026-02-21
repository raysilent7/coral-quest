extends Node2D

const blockSize = 32

var fallInterval = 1.2
var fallTimer = 0.0
var board = null
var activePiece: Node2D = null
var moveDelay = 0.15
var moveTimer = 0.0

func _ready():
	board = get_parent()

func _process(delta):
	if activePiece == null:
		return

	fallTimer += delta
	if fallTimer >= fallInterval:
		fallTimer = 0.0
		movePiece(Vector2(0, 1))

	moveTimer -= delta
	if moveTimer <= 0:
		if Input.is_action_pressed("moveLeft"):
			movePiece(Vector2(-1, 0))
			moveTimer = moveDelay
		elif Input.is_action_pressed("moveRight"):
			movePiece(Vector2(1, 0))
			moveTimer = moveDelay
		elif Input.is_action_pressed("moveDown"):
			movePiece(Vector2(0, 1))
			moveTimer = moveDelay

	if Input.is_action_just_pressed("jump"):
		rotatePiece()


func setActivePiece(piece: Node2D):
	if activePiece != null:
		activePiece.queue_free()
	activePiece = piece
	add_child(activePiece)

func movePiece(direction: Vector2):
	activePiece.position += direction * blockSize

	if isColliding():
		activePiece.position -= direction * blockSize
		if direction == Vector2(0, 1):
			board.fixPiece(activePiece)
			activePiece = null
			get_parent().get_parent().spawnNewPiece()

func rotatePiece():
	for block in activePiece.get_children():
		var oldPos = block.position / blockSize
		var newPos = Vector2(-oldPos.y, oldPos.x)
		block.position = newPos * blockSize

	# desfaz rotação se colidir
	if isColliding():
		for block in activePiece.get_children():
			var oldPos = block.position / blockSize
			var newPos = Vector2(oldPos.y, -oldPos.x)
			block.position = newPos * blockSize

func isColliding() -> bool:
	for block in activePiece.get_children():
		var pos = (activePiece.position / blockSize) + (block.position / blockSize)
		var x = int(pos.x)
		var y = int(pos.y)

		if x < 0 or x >= board.boardWidth or y >= board.boardHeight:
			return true
		if y >= 0 and board.board[y][x] != null:
			return true
	return false

func onTimerTimeout() -> void:
	print("fiquei mais rapido: tetris")
	if fallInterval >= 0.2:
		fallInterval -= 0.05
		print(fallInterval)
