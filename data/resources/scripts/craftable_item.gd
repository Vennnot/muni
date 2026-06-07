class_name CraftableItem
extends Item

enum SKILL {none, smithing}

@export var skill : SKILL
@export var ingredients : Dictionary[int,int]
