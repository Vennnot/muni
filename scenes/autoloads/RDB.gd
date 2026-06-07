extends Node

const ALL_ITEMS := preload("uid://b6eto0fe3nu3p")

var all_items : Array[Item]

var gatherable_items : Array[GatherableItem]
var craftable_items : Array[CraftableItem]
var upgradeable_items : Array[UpgradeableItem]

func _ready() -> void:
	ALL_ITEMS.load_all_into(all_items)
	print(all_items)
	_sort_items()

func _sort_items() -> void:
	for item in all_items:
		if item is GatherableItem:
			gatherable_items.append(item)
		elif item is CraftableItem:
			craftable_items.append(item)
		elif item is UpgradeableItem:
			upgradeable_items.append(item)


func get_item(type: Script) -> Item:
	match type:
		GatherableItem:
			return get_gatherable_item()
	return null


func get_gatherable_item() -> GatherableItem:
	var skill := Global.skill
	var location := Global.location
	var filtered: Array[GatherableItem] = gatherable_items.filter(
		func(i: GatherableItem) -> bool:
			return i.skill == skill and i.location == location)
	if filtered.is_empty():
		return null
	return filtered.pick_random()
