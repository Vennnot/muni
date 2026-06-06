class_name World
extends Node2D

const GATHERING_NODE := preload("uid://d2nbfffmx3als")

@onready var muni: Muni = %Muni
@onready var muni_camera: WindowedCamera = %MuniCamera
@onready var world_rect: ColorRect = %WorldRect

func _ready() -> void:
	world_rect.queue_free()
	muni.target_resource = _assign_random_x(create_new_object())


func create_new_object(scene:PackedScene=GATHERING_NODE)->Node2D:
	var window :ObjectWindow= get_parent()._create_window()
	var node := scene.instantiate()
	window.assign_node(node)
	return node


func _assign_random_x(node: Node2D) -> Node2D:
	var rect :Rect2= node.get_sprite_rect()
	node.position.x = randf_range(rect.size.x / 2.0, ScreenHelper.world_size.x - rect.size.x / 2.0)
	node.position.y = ScreenHelper.world_size.y - rect.size.y / 2.0
	return node
