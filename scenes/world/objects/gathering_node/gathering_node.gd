class_name GatheringNode
extends Node2D

signal exhausted

@onready var sprite: Sprite2D = $Sprite

var item : GatherableItem
var muni : Muni

func setup(i:GatherableItem)->void:
	item = i
	sprite.texture = item.node_texture
	sprite.visible = true


func get_sprite_rect()->Rect2:
	return sprite.get_rect()


func interact()->void:
	Global.game_manager.inventory.add(item.id,1)
	despawn()


func despawn()->void:
	exhausted.emit()
	muni.unassign_resource()
	queue_free()
