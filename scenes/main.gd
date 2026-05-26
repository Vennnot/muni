class_name Main
extends Node

@onready var main_window: Window = get_window()
@onready var camera_window: CameraWindow = $CameraWindow

func _ready():
	camera_window.world_2d = main_window.world_2d
