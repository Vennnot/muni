extends Node

signal screen_changed
signal manual_scaling_changed
signal world_scale_changed
signal ui_scale_changed(scale:float)


var allow_manual_scaling := false :
	set(value):
		allow_manual_scaling = value
		if not allow_manual_scaling:
			manual_scale = get_integer_scale()
		manual_scaling_changed.emit()
var manual_scale := 0 :
	set(value):
		manual_scale = clampi(value, 1, 7)
		world_scale_changed.emit()
var ui_scale : float = 3 :
	set(value):
		ui_scale = clampf(value,1,5)
		ui_scale_changed.emit(ui_scale)

var world_size := Vector2(640,360)
var current_screen: int = DisplayServer.get_primary_screen()
var screen_position: Vector2i = DisplayServer.screen_get_position(current_screen)
var world_scale: Vector2 = _calc_scaling():
	set(value):
		if world_scale == value:
			return
		world_scale = value
		world_scale_changed.emit()

func _ready() -> void:
	manual_scale = get_integer_scale()


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
		return
	current_screen = screen
	_update()


func _update() -> void:
	screen_position = DisplayServer.screen_get_position(current_screen)
	world_scale = _calc_scaling()
	screen_changed.emit()


func get_integer_scale()->int:
	if allow_manual_scaling:
		return manual_scale
	else:
		return mini(world_scale.x, world_scale.y)


func get_window_offset() -> Vector2i:
	var integer_scale: int = get_integer_scale()
	var used := Vector2i(640, 360) * integer_scale
	var size := get_screen_size(false)  # always full screen
	return Vector2i((size.x - used.x) / 2, (size.y - used.y) / 2)


func get_screen_size(taskbar: bool = true) -> Vector2i:
	if taskbar:
		return DisplayServer.screen_get_usable_rect(current_screen).size
	return DisplayServer.screen_get_size(current_screen)
