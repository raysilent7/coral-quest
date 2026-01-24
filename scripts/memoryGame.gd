extends Node2D

@export var cardScene: PackedScene
@export var rows: int = 4
@export var cols: int = 4
@export var spacing: Vector2 = Vector2(120, 120)

var firstCard: Node2D = null
var secondCard: Node2D = null
var canClick: bool = true
var points: int = 0

var flipAnimations = [
	"flipNababa", "flipStar", "flipKiko", "flipGrubble", "flipTrident", "flipComb", "flipFish", "flipClamp"
]
var deck = []

func _ready():
	for anim in flipAnimations:
		deck.append(anim)
		deck.append(anim)

	deck.shuffle()
	buildBoard()

func buildBoard():
	var index = 0
	for row in range(rows):
		for col in range(cols):
			var card = cardScene.instantiate()

			add_child(card)

			card.position = Vector2(col * spacing.x, row * spacing.y)
			card.flipAnimation = deck[index]
			card.unflipAnimation = resolveUnflipAnimation(deck[index])

			index += 1

func resolveUnflipAnimation(flipAnim: String) -> String:
	if "flipNababa" == flipAnim:
		return "unflipNababa"
	elif "flipStar" == flipAnim:
		return "unflipStar"
	elif "flipKiko" == flipAnim:
		return "unflipKiko"
	elif "flipGrubble" == flipAnim:
		return "unflipGrubble"
	elif "flipTrident" == flipAnim:
		return "unflipTrident"
	elif "flipComb" == flipAnim:
		return "unflipComb"
	elif "flipFish" == flipAnim:
		return "unflipFish"
	elif "flipClamp" == flipAnim:
		return "unflipClamp"
	return "default"

func onCardRevealed(card: Node2D):
	if not canClick:
		return

	if firstCard == null:
		firstCard = card
		firstCard.isFlipped = true
	elif secondCard == null and card != firstCard:
		secondCard = card
		secondCard.isFlipped = true
		canClick = false
		compareCards()

func compareCards():
	if firstCard.flipAnimation == secondCard.flipAnimation:
		firstCard = null
		secondCard = null
		canClick = true
		points += 1
		if points == 8:
			print("Parabens! Voce venceu.")
	else:
		await get_tree().create_timer(1.0).timeout
		firstCard.playUnflipAnimation()
		secondCard.playUnflipAnimation()
		firstCard.isFlipped = false
		secondCard.isFlipped = false
		firstCard = null
		secondCard = null
		canClick = true
