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


func get_window_pos()->Vector2i: 
	return ScreenHelper.screen_position + Vector2i(Vector2(global_position + offset - object_size / 2) * ScreenHelper.world_scale)

func _physics_process(delta: float) -> void:
	if not window:
		return
	
	window.position = get_window_pos()
