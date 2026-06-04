class_name WindowedCamera
extends Camera2D

@export var object_size : Vector2 = Vector2i(16,16)
var window : Window : set = _set_window

func _ready() -> void:
	set_physics_process(false)
	ScreenHelper.world_scale_changed.connect(_on_world_scale_changed)
	_on_world_scale_changed()


func _set_window(w:Window)->void:
	window = w
	window.current_screen = ScreenHelper.current_screen
	window.min_size = object_size * Vector2(zoom)
	window.size = window.min_size
	set_physics_process(true)


func _on_world_scale_changed()->void:
	zoom = Vector2.ONE * ScreenHelper.get_integer_scale()


func get_window_pos() -> Vector2i:
	var int_scale: int = ScreenHelper.get_integer_scale()
	var screen := Vector2(ScreenHelper.get_screen_size())
	var world := Vector2(640, 360) * int_scale
	var world_pos := global_position + offset - object_size / 2
	var ratio := Vector2(world_pos.x / 640.0, world_pos.y / 360.0)
	var margin := (screen - world)
	var result := ScreenHelper.screen_position + Vector2i(world_pos * int_scale + margin * ratio)

	var usable := DisplayServer.screen_get_usable_rect(ScreenHelper.current_screen)
	result.y = maxi(result.y, usable.position.y)
	result.x = maxi(result.x, ScreenHelper.screen_position.x)
	result.y = mini(result.y, usable.position.y + usable.size.y - int(window.size.y))
	result.x = mini(result.x, ScreenHelper.screen_position.x + int(ScreenHelper.get_screen_size().x) - int(window.size.x))
	return result

func _physics_process(delta: float) -> void:
	if not window:
		return
	print(DisplayServer.screen_get_usable_rect(ScreenHelper.current_screen))
	window.position = get_window_pos()
