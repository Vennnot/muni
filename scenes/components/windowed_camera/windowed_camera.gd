class_name WindowedCamera
extends Camera2D

@export var object_size : Vector2 = Vector2i(16,16) :
	set(value):
		object_size = value
		_on_world_scale_changed()
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
	if window:
		window.current_screen = ScreenHelper.current_screen
		window.min_size = object_size * Vector2(zoom)
		window.size = window.min_size


func get_window_pos() -> Vector2i:
	var int_scale: int = ScreenHelper.get_integer_scale()
	var usable := DisplayServer.screen_get_usable_rect(ScreenHelper.current_screen)
	var screen := Vector2(usable.size)
	var origin := Vector2i(usable.position)
	var world := ScreenHelper.world_size * int_scale
	var world_pos := global_position + offset - object_size / 2
	var ratio := Vector2(world_pos.x / (ScreenHelper.world_size.x - object_size.x), world_pos.y / (ScreenHelper.world_size.y - object_size.y))
	var margin := (screen - world)
	var result := origin + Vector2i(world_pos * int_scale + margin * ratio)
	#print("global_position: ", global_position)
	#print("world_pos: ", world_pos)
	#print("ratio: ", ratio)
	#print("margin: ", margin)
	#print("origin: ", origin)
	#print("result: ", result)
	#print("int_scale: ", int_scale)
	#print("world_pos * int_scale: ", world_pos * int_scale)
	result.y = maxi(result.y, usable.position.y)
	result.x = maxi(result.x, usable.position.x)
	result.y = mini(result.y, usable.position.y + usable.size.y - int(window.size.y))
	result.x = mini(result.x, usable.position.x + usable.size.x - int(window.size.x))
	return result

func _physics_process(delta: float) -> void:
	if not window:
		return
	window.position = get_window_pos()
