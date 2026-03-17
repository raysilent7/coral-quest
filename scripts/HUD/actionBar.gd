extends Control

var slots: Array = [null, null, null, null, null]
var names: Array = ["nada", "nada", "nada", "nada", "nada"]
@onready var slot_nodes = [
	$item1,
	$item2,
	$item3,
	$item4,
	$item5
]

func _ready():
	var savedIcons = GameState.loadActionBarTextures()
	var savedNames = GameState.loadActionBarNames()
	for i in range(savedIcons.size()):
		slots[i] = savedIcons[i]
		names[i] = savedNames[i]
		slot_nodes[i].texture = savedIcons[i]

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1: useItem(0, names[0])
			KEY_2: useItem(1, names[1])
			KEY_3: useItem(2, names[2])
			KEY_4: useItem(3, names[3])
			KEY_5: useItem(4, names[4])

func addItem(itemIcon: Texture, itemName: String):
	for i in range(slots.size()):
		if slots[i] == null:
			slots[i] = itemIcon
			names[i] = itemName
			slot_nodes[i].texture = itemIcon
			GameState.saveActionBarTextures(slots)
			GameState.saveActionBarNames(names)
			return
	print("Action bar cheia!")

func useItem(index: int, itemName: String):
	if slots[index] != null:
		print("usei o item: " + str(index) + itemName)
		highlightSlot(index)
		GameState.selectedItem = itemName
		if GameState.selectedItem == "grubbleFruit":
			get_parent().refillOxygen()
	else:
		print("Slot vazio: " + str(index))

func highlightSlot(index: int):
	for i in range(slot_nodes.size()):
		if i == index:
			slot_nodes[i].modulate = Color(1, 1, 0.5) # amarelado
		else:
			slot_nodes[i].modulate = Color(1, 1, 1)   # normal
