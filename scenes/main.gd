class_name Main
extends Node

const OBJECT_WINDOW :=preload("uid://vscdnq3w5316")
const WORLD :=preload("uid://dc38vkwwx70q1")
const UI_WINDOW = preload("uid://122tqjcnn7wr")
const TOGGLE_BUTTON_WINDOW = preload("uid://botyc2rllbsx6")

@export_range(0, 19) var ui_visibility_layer: int = 2
@export_range(0, 19) var player_visibility_layer: int = 1
@export_range(0, 19) var world_visibility_layer: int = 0

var main_window: Window
var camera_window: CameraWindow
var world : World

func _ready():
	main_window = get_window()
	set_physics_process(false)
	_spawn_world()
	_set_culling_masks()
	set_physics_process(true)
	

	var ui_button : UIWindow = _create_toggle_button_window()
	var ui :UIWindow= _create_UI_window()

func _create_window()->ObjectWindow:
	var object_window := OBJECT_WINDOW.instantiate()
	add_child(object_window)
	object_window.world_2d = main_window.world_2d
	return object_window


func _create_UI_window()->UIWindow:
	var ui_window := UI_WINDOW.instantiate()
	add_child(ui_window)
	ui_window.world_2d = main_window.world_2d
	return ui_window


func _create_toggle_button_window()->UIWindow:
	var ui_window := TOGGLE_BUTTON_WINDOW.instantiate()
	add_child(ui_window)
	var screen_size: Vector2 = DisplayServer.screen_get_size(ui_window.camera.current_screen)
	ui_window.position = DisplayServer.screen_get_position(ui_window.camera.current_screen) + Vector2i(screen_size) - Vector2i(ui_window.size)
	return ui_window


func _set_culling_masks()->void:
	main_window.set_canvas_cull_mask_bit(player_visibility_layer, true)
	main_window.set_canvas_cull_mask_bit(world_visibility_layer, false)
	main_window.set_canvas_cull_mask_bit(ui_visibility_layer, false)


func _spawn_world()->void:
	world = WORLD.instantiate()
	add_child(world)
	world.muni_camera._set_window(main_window)
