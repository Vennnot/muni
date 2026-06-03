class_name Main
extends Node

@onready var camera_window: CameraWindow = $CameraWindow
@export var muni_camera : Camera2D
var world_camera : Camera2D
var main_window: Window

@export_range(0, 19) var player_visibility_layer: int = 2
@export_range(0, 19) var world_visibility_layer: int = 0
@export var object_size := Vector2i(64, 64)

func _ready():
	main_window = get_window()
	_set_main_window_invis()
	_set_window_size()
	
	main_window.set_canvas_cull_mask_bit(player_visibility_layer, true)
	main_window.set_canvas_cull_mask_bit(world_visibility_layer, false)
	camera_window.set_canvas_cull_mask_bit(player_visibility_layer, false)
	camera_window.set_canvas_cull_mask_bit(world_visibility_layer, true)
	
	camera_window.world_2d = main_window.world_2d


func _set_window_size()->void:
	main_window.min_size = object_size
	main_window.size = main_window.min_size
	main_window.min_size = object_size * Vector2i(muni_camera.zoom)
	main_window.size = main_window.min_size


func _set_main_window_invis()->void:
	# Enable per-pixel transparency, required for transparent windows but has a performance cost
	# Can also break on some systems
	ProjectSettings.set_setting("display/window/per_pixel_transparency/allowed", true)
	# Set the window settings - most of them can be set in the project settings
	main_window.borderless = true		# Hide the edges of the window
	main_window.unresizable = true		# Prevent resizing the window
	main_window.always_on_top = true	# Force the window always be on top of the screen
	main_window.gui_embed_subwindows = false # Make subwindows actual system windows <- VERY IMPORTANT
	main_window.transparent = true		# Allow the window to be transparent
	# Settings that cannot be set in project settings
	main_window.transparent_bg = true	# Make the window's background transparent


func _process(delta):
	# Update the main window's position
	main_window.position = get_window_pos_from_camera()


func get_window_pos_from_camera()->Vector2i:
	return (Vector2i(muni_camera.global_position + muni_camera.offset) - object_size / 2) * Vector2i(muni_camera.zoom)
