class_name GatheringNode
extends Node2D

@onready var sprite: Sprite2D = $Sprite

var muni : Muni

func setup()->void:
	pass


func get_sprite_rect()->Rect2:
	return sprite.get_rect()


func interact()->void:
	despawn()


func despawn()->void:
	muni.unassign_resource()
	queue_free()
