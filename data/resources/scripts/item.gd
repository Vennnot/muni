class_name Item
extends Resource

enum USE {ingredient, consumable, equippable, decoration}

@export var id : String = ""
@export var texture : Texture

@export_category("Game Information")
@export var value : int = 0
@export var location : Global.LOCATION
@export var skill : Global.SKILL

@export_group("Tags","tags_")
@export var tags_use : Array[USE]
