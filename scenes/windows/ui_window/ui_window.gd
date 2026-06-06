class_name UIWindow
extends Window

@export var window_name : String
@onready var camera: UICamera = %UICamera
var ui : Control

func _ready() -> void:
	close_requested.connect(queue_free)
	camera.anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	camera.window = self
	ui = camera.ui
