class_name World
extends Node2D

const GATHERING_NODE := preload("uid://d2nbfffmx3als")

@onready var muni: Muni = %Muni
@onready var muni_camera: WindowedCamera = %MuniCamera
@onready var world_rect: ColorRect = %WorldRect

var world_objects :Array[Node2D]

func _ready() -> void:
	world_rect.queue_free()
	muni.target_requested.connect(_on_target_requested)
	_on_node_exhausted(null)


func create_new_object(scene:PackedScene=GATHERING_NODE)->Node2D:
	var window :ObjectWindow= get_parent()._create_window()
	var node := scene.instantiate()
	window.assign_node(node)
	_assign_random_x(node)
	world_objects.append(node)
	node.exhausted.connect(_on_node_exhausted.bind(node))
	return node


func create_new_gathering_node(item:GatherableItem)->Node2D:
	var gathering_node : GatheringNode = create_new_object()
	gathering_node.setup(item)
	return gathering_node


func _assign_random_x(node: Node2D) -> Node2D:
	var rect :Rect2= node.get_sprite_rect()
	node.position.x = randf_range(rect.size.x / 2.0, ScreenHelper.world_size.x - rect.size.x / 2.0)
	node.position.y = ScreenHelper.world_size.y - rect.size.y / 2.0
	return node


func _on_target_requested() -> void:
	if not world_objects:
		return
	var closest: Node2D = world_objects[0]
	for obj: Node2D in world_objects:
		if abs(obj.position.x - muni.position.x) < abs(closest.position.x - muni.position.x):
			closest = obj
	muni.target_resource = closest


func _on_node_exhausted(node:Node2D)->void:
	world_objects.erase(node)
	while world_objects.size()<2:
		var item := _get_gathering_resource()
		if item:
			create_new_gathering_node(item)


func _get_gathering_resource()->GatherableItem:
	return RDB.get_gatherable_item()
