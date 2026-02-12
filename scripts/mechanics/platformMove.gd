extends Node2D

@export var pointA: Vector2
@export var pointB: Vector2
@export var speed: float = 0.7
@export var fromFirstMinigame: bool
@export var fromSecondMinigame: bool
@export var fromThirdMinigame: bool
@export var fromFourthMinigame: bool

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

func moveFromFirstMinigame():
	if fromFirstMinigame:
		if movingToB and GameState.beatFirstPuzzle:
			global_position = global_position.move_toward(pointB, speed)
			if global_position == pointB:
				movingToB = false
		elif not movingToB and GameState.beatFirstPuzzle:
			global_position = global_position.move_toward(pointA, speed)
			if global_position == pointA:
				movingToB = true

func moveFromSecondMinigame():
	if fromSecondMinigame:
		if movingToB and GameState.beatSecondPuzzle:
			global_position = global_position.move_toward(pointB, speed)
			if global_position == pointB:
				movingToB = false
		elif not movingToB and GameState.beatFirstPuzzle:
			global_position = global_position.move_toward(pointA, speed)
			if global_position == pointA:
				movingToB = true

func _onBodyEntered(body):
	if body is CharacterBody2D:
		player = body

func _onBodyExited(body):
	if body is CharacterBody2D:
		player = null
