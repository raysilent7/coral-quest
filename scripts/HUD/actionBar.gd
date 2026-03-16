extends Control

var slots: Array = [null, null, null, null, null]
@onready var slot_nodes = [
	$item1,
	$item2,
	$item3,
	$item4,
	$item5
]

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1: useItem(0, slots[0])
			KEY_2: useItem(1, slots[1])
			KEY_3: useItem(2, slots[2])
			KEY_4: useItem(3, slots[3])
			KEY_5: useItem(4, slots[4])

func addItem(itemIcon: Texture, itemName: String):
	for i in range(slots.size()):
		if slots[i] == null:
			slots[i] = itemName
			slot_nodes[i].texture = itemIcon
			return
	print("Action bar cheia!")

func useItem(index: int, itemName: String):
	if slots[index] != null:
		highlightSlot(index)
		GameState.selectedItem = itemName
	else:
		print("Slot vazio: " + str(index))

func highlightSlot(index: int):
	for i in range(slot_nodes.size()):
		if i == index:
			slot_nodes[i].modulate = Color(1, 1, 0.5) # amarelado
		else:
			slot_nodes[i].modulate = Color(1, 1, 1)   # normal
