class_name Main
extends Node

const CAMERA_WINDOW :=preload("uid://bp1wdfq4jn3od")
const WORLD :=preload("uid://dc38vkwwx70q1")

@export_range(0, 19) var player_visibility_layer: int = 2
@export_range(0, 19) var world_visibility_layer: int = 0

var main_window: Window
var camera_window: CameraWindow
var world : World

func _ready():
	set_physics_process(false)
	_set_main_window_invis()
	_spawn_camera_window()
	_spawn_world()
	_set_culling_masks()
	set_physics_process(true)


func _set_main_window_invis()->void:
	main_window = get_window()
	main_window.borderless = true
	main_window.unresizable = true
	main_window.always_on_top = true
	main_window.gui_embed_subwindows = false
	main_window.transparent = true
	# Settings that cannot be set in project settings
	main_window.transparent_bg = true	# Make the window's background transparent


func _set_culling_masks()->void:
	main_window.set_canvas_cull_mask_bit(player_visibility_layer, true)
	main_window.set_canvas_cull_mask_bit(world_visibility_layer, false)
	camera_window.set_canvas_cull_mask_bit(player_visibility_layer, false)
	camera_window.set_canvas_cull_mask_bit(world_visibility_layer, true)


func _spawn_camera_window()->void:
	camera_window = CAMERA_WINDOW.instantiate()
	add_child(camera_window)
	camera_window.world_2d = main_window.world_2d


func _spawn_world()->void:
	world = WORLD.instantiate()
	add_child(world)
	world.muni_camera.window = main_window
