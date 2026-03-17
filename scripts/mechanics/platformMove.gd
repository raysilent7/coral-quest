extends Node2D

@export var pointA: Vector2
@export var pointB: Vector2
@export var speed: float = 0.7
@export var fromFirstMinigame: bool
@export var fromKikoFruit: bool
@export var fromThirdMinigame: bool

var movingToB: bool = true
var lastPosition: Vector2
var player: Node = null

func _ready():
	$StaticBody2D/detector.body_entered.connect(_onBodyEntered)
	$StaticBody2D/detector.body_exited.connect(_onBodyExited)

func _process(delta):
	var movement = global_position - lastPosition
	lastPosition = global_position

	if player:
		player.global_position += movement
	
	moveFromFirstMinigame()
	moveFromKikoFruit()
	moveFromThirdMinigame()

func moveFromFirstMinigame():
	if fromFirstMinigame:
		if movingToB and GameState.beatFirstPuzzle:
			moveToB()
			if global_position == pointB:
				movingToB = false
		elif not movingToB and GameState.beatFirstPuzzle:
			moveToA()
			if global_position == pointA:
				movingToB = true

func moveFromKikoFruit():
	if fromKikoFruit and player and GameState.selectedItem == "kikoFruit":
		moveToB()

func moveFromThirdMinigame():
	if fromThirdMinigame and GameState.beatThirdPuzzle:
		moveToB()

func moveToA():
	global_position = global_position.move_toward(pointA, speed)

func moveToB():
	global_position = global_position.move_toward(pointB, speed)

func _onBodyEntered(body):
	if body is CharacterBody2D:
		player = body

func _onBodyExited(body):
	if body is CharacterBody2D:
		player = null
