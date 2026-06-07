class_name Item
extends Resource

enum TYPE {gatherable, craftable, upgradeable}
enum USE {ingredient, consumable, equippable, decoration}

@export var id : int = -1
@export var texture : Texture

@export_category("Game Information")
@export var value : int = 0

@export_group("Tags","tags_")
@export var tags_type : Array[String]
@export var tags_use : Array[String]
