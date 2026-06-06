class_name GatheringNode
extends Node2D

signal exhausted

@onready var sprite: Sprite2D = $Sprite

var muni : Muni

func setup()->void:
	pass


func get_sprite_rect()->Rect2:
	return sprite.get_rect()


func interact()->void:
	Global.game_manager.inventory.add(1,1)
	despawn()


func despawn()->void:
	exhausted.emit()
	muni.unassign_resource()
	queue_free()
