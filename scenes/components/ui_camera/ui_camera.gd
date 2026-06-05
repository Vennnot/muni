class_name UICamera
extends Camera2D

@export var ui : Control
var window : Window : set = _set_window
var current_screen : int = -1
var screen_position : Vector2 = Vector2(-1,-1)


func _ready() -> void:
	if current_screen == -1:
		current_screen = DisplayServer.get_primary_screen()
	if screen_position == Vector2(-1,-1):
		screen_position = DisplayServer.screen_get_position(current_screen)


func _set_window(w:Window)->void:
	window = w
	window.current_screen = ScreenHelper.current_screen
	window.min_size = ui.size * Vector2(zoom)
	window.size = window.min_size
	var screen_size: Vector2 = DisplayServer.screen_get_size(current_screen)
	window.position = DisplayServer.screen_get_position(current_screen) + Vector2i((screen_size - Vector2(window.size)) / 2.0)
