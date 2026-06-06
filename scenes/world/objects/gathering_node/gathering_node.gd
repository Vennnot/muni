class_name GatheringNode
extends Node2D

@onready var sprite: Sprite2D = $Sprite

func setup()->void:
	pass


func get_sprite_rect()->Rect2:
	return sprite.get_rect()
