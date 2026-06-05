class_name UIWindow
extends Window

@onready var camera: UICamera = %UICamera
var ui : Control

func _ready() -> void:
	Global.ui_scale_changed.connect(_on_ui_scale_changed)
	close_requested.connect(queue_free)
	camera.anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	camera.window = self
	ui = camera.ui


func _on_ui_scale_changed(scale:int)->void:
	ui.size = ui.get_minimum_size()*scale
