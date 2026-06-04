extends Node

signal screen_changed
signal world_scale_changed
signal ui_scale_changed

var world_size := Vector2(640,360)
var current_screen: int = DisplayServer.get_primary_screen()
var screen_position: Vector2i = DisplayServer.screen_get_position(current_screen)
var world_scale: Vector2 = _calc_scaling():
	set(value):
		if world_scale == value:
			return
		world_scale = value
		world_scale_changed.emit()


func _calc_scaling() -> Vector2:
	var size: Vector2 = get_screen_size(false)
	var scale_x: float = size.x / 640
	var scale_y: float = size.y / 360
	return Vector2(scale_x, scale_y)


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
	screen_position = DisplayServer.screen_get_position(current_screen)
	world_scale = _calc_scaling()
	screen_changed.emit()


func get_integer_scale()->int:
	return mini(world_scale.x,world_scale.y)


func get_window_offset() -> Vector2i:
	var integer_scale: int = get_integer_scale()
	var used := Vector2i(640, 360) * integer_scale
	var size := get_screen_size(false)  # always full screen
	return Vector2i((size.x - used.x) / 2, (size.y - used.y) / 2)


func get_screen_size(taskbar: bool = true) -> Vector2i:
	if taskbar:
		return DisplayServer.screen_get_usable_rect(current_screen).size
	return DisplayServer.screen_get_size(current_screen)
