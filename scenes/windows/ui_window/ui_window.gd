class_name UIWindow
extends Window

@onready var camera: WindowedCamera = %WindowedCamera
@onready var ui_object: Control = %UIObject


func _ready() -> void:
	camera.object_size = ui_object.size
	close_requested.connect(queue_free)
	camera.anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	camera.window = self
