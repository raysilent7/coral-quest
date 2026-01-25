extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $diverAnimation

func _physics_process(delta: float) -> void:
	if GameState.isInWater:
		moveCharacter(80, delta)
		jump(-80, true)
		move_and_slide()
		updateAnimation(getSwimAnimation())
	else:
		apply_floor_snap()
		moveCharacter(150, delta)
		jump(-280, is_on_floor())
		move_and_slide()
		updateAnimation(getGroundAnimation())

func moveCharacter(velValue: int, delta: float) -> void:
	if Input.is_action_pressed("moveRight"):
		velocity.x = velValue
		anim.flip_h = false
	elif Input.is_action_pressed("moveLeft"):
		velocity.x = -velValue
		anim.flip_h = true
	else:
		velocity.x = 0

	if not is_on_floor():
		velocity.y += velValue * (delta * 4)
	else:
		velocity.y = 0

func jump(jumpForce: int, canJumpAgain: bool) -> void:
	if Input.is_action_just_pressed("jump") and canJumpAgain:
		velocity.y = jumpForce
	
func updateAnimation(state: String) -> void:
	if anim.animation != state:
		anim.play(state)

func getGroundAnimation() -> String:
	if velocity.x > 0 and is_on_floor():
		return "walk"
	if velocity.x < 0 and is_on_floor():
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
