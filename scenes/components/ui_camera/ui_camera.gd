class_name UICamera
extends Camera2D

@export var ui : Control
var window : Window : set = _set_window
var current_screen : int = -1
var screen_position : Vector2 = Vector2(-1,-1)


func _ready() -> void:
	ScreenHelper.ui_scale_changed.connect(_on_ui_scale_changed)
	if current_screen == -1:
		current_screen = DisplayServer.get_primary_screen()
	if screen_position == Vector2(-1,-1):
		screen_position = DisplayServer.screen_get_position(current_screen)


func _set_window(w:Window)->void:
	window = w
	_update_window()
	var screen_size: Vector2 = DisplayServer.screen_get_size(current_screen)
	window.position = DisplayServer.screen_get_position(current_screen) + Vector2i((screen_size - Vector2(window.size)) / 2.0)
	ScreenHelper.ui_scale = ScreenHelper.ui_scale


func _on_ui_scale_changed(_scale: float) -> void:
	if not window:
		return
	var screen_size: Vector2 = DisplayServer.screen_get_size(current_screen)
	var screen_origin: Vector2 = DisplayServer.screen_get_position(current_screen)
	var relative: Vector2 = (Vector2(window.position) - screen_origin) / screen_size
	await get_tree().process_frame
	_update_window()
	window.position = Vector2i(screen_origin + relative * screen_size)


func _update_window()->void:
	if not window:
		return
	window.current_screen = ScreenHelper.current_screen
	window.min_size = ui.size * Vector2(zoom)
	window.size = window.min_size
	
