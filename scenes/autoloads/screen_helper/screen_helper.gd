extends Node

signal screen_changed
signal world_scale_changed
signal ui_scale_changed

var world_size := Vector2(640,360)
var current_screen: int = DisplayServer.get_primary_screen()
var screen_size: Vector2i = DisplayServer.screen_get_size(current_screen)
var screen_position: Vector2i = DisplayServer.screen_get_position(current_screen)
var world_scale: int = _calc_scaling(screen_size):
	set(value):
		if world_scale == value:
			return
		world_scale = value
		world_scale_changed.emit()


func _calc_scaling(size: Vector2i) -> int:
	var scale_x: int = size.x / 640
	var scale_y: int = size.y / 360
	return mini(scale_x, scale_y)


func get_available_screens() -> Array[int]:
	var screens: Array[int] = []
	for i: int in DisplayServer.get_screen_count():
		screens.append(i)
	return screens


func set_screen(screen: int) -> void:
	if screen < 0 or screen >= DisplayServer.get_screen_count():
		push_error("Invalid screen index: %d" % screen)
		return
	current_screen = screen
	_update()


func _update() -> void:
	screen_size = DisplayServer.screen_get_size(current_screen)
	screen_position = DisplayServer.screen_get_position(current_screen)
	world_scale = _calc_scaling(screen_size)
	screen_changed.emit()
