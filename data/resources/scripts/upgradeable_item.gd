class_name UpgradeableItem
extends Item

enum SKILL {none, mining}

@export var skill : SKILL

#FIXME Nested Dictionary[level:int,Dictionary[id:int,amount:int]
#where do I save the stats increase
@export var ingredients_per_level : Dictionary
