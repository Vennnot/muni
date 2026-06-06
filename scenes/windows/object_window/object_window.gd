class_name ObjectWindow
extends Window

@onready var world_object: WorldObject = %WorldObject
@onready var camera: WindowedCamera = %WindowedCamera

func _ready() -> void:
	close_requested.connect(queue_free)
	camera.anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	camera.window = self

func assign_node(node:Node2D)->Node2D:
	add_child(node)
	camera.reparent(node)
	world_object.queue_free()
	return node
