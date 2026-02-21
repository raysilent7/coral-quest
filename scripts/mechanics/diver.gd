extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $diverAnimation
@onready var light: PointLight2D = $light
@onready var camera: Camera2D = $camera

func _process(delta: float) -> void:
	if GameState.isDark and GameState.selectedItem != "starFruit":
		light.energy = 1.0
	elif GameState.selectedItem == "starFruit":
		light.energy = 1.0
		light.texture_scale = 5
	else:
		light.energy = 0.0

func _physics_process(delta: float) -> void:
	if GameState.isInWater:
		moveInWater(delta)
	elif GameState.isInFishingLinesGame:
		moveInMinigame(delta)
	else:
		moveOnGround(delta)

func moveOnGround(delta: float):
	moveCharacter(150, delta, 300)
	jump(-310, is_on_floor())
	move_and_slide()
	updateAnimation(getGroundAnimation())

func moveInMinigame(delta: float):
	applyGravity(80, delta, 300)
	jump(-120, true)
	move_and_slide()
	updateAnimation(getSwimAnimation())

func moveInWater(delta: float):
	moveCharacter(80, delta, 300)
	jump(-120, true)
	move_and_slide()
	updateAnimation(getSwimAnimation())

func moveCharacter(velValue: int, delta: float, maxFallSpeed: float) -> void:
	if Input.is_action_pressed("moveRight"):
		velocity.x = velValue
		anim.flip_h = false
	elif Input.is_action_pressed("moveLeft"):
		velocity.x = -velValue
		anim.flip_h = true
	else:
		velocity.x = 0

	applyGravity(velValue, delta, maxFallSpeed)

func applyGravity(velValue: int, delta: float, maxFallSpeed: float):
	if not is_on_floor():
		velocity.y += velValue * (delta * 4)
		velocity.y = min(velocity.y, maxFallSpeed)
	else:
		velocity.y = 0


func jump(jumpForce: int, canJumpAgain: bool) -> void:
	if Input.is_action_just_pressed("jump") and canJumpAgain:
		velocity.y = jumpForce

func updateAnimation(state: String) -> void:
	if anim.animation != state:
		anim.play(state)

func getGroundAnimation() -> String:
	if velocity.x != 0 and is_on_floor():
		return "walk"
	elif not is_on_floor():
		return "jump"
	else:
		return "idle"

func getSwimAnimation() -> String:
	if velocity.x != 0 and not is_on_floor():
		return "swim"
	elif velocity.x != 0 and is_on_floor():
		return "walk"
	elif velocity.x == 0 and not is_on_floor():
		return "idleSwim"
	else:
		return "idle"

func disableCamera():
	camera.enabled = false

func enableCamera():
	camera.enabled = true
