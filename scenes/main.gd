class_name Main
extends Node

@onready var world: Node2D = %World
@onready var ui: CanvasLayer = %UI

var captured := false

func _ready() -> void:
	EventBus.captured_mouse.connect(_on_capture)
	EventBus.released_mouse.connect(_on_release)
	
	_release()


func _capture()->void:
	DisplayServer.window_set_mouse_passthrough(PackedVector2Array())
	captured = true
	set_physics_process_internal(false)
	print("captured")
	world.modulate = Color.RED


func _release()->void:
	DisplayServer.window_set_mouse_passthrough(PackedVector2Array([Vector2(0,0)]))
	captured = false
	set_physics_process_internal(true)
	print("released")
	world.modulate = Color.BLUE



func _physics_process(_delta: float) -> void:
	if (is_hovering_world_element() or is_hovering_ui()) and not captured:
		DisplayServer.window_set_mouse_passthrough(PackedVector2Array())


func is_hovering_world_element() -> bool:
	var mouse_pos := get_viewport().get_mouse_position()
	var space_state := world.get_world_2d().direct_space_state
	var query := PhysicsPointQueryParameters2D.new()
	query.position = mouse_pos
	query.collide_with_areas = true
	query.collision_mask = 0b1  # Layer 1 (bit index 1)
	
	var result := space_state.intersect_point(query)
	return not result.is_empty()


func is_hovering_ui() -> bool:
	if not ui.visible:
		return false
	
	var mouse_pos := get_viewport().get_mouse_position()
	return ui.get_all_global_rects().has_point(mouse_pos)


#DisplayServer.mouse_get_position() and DisplayServer.window_get_position()?

func _on_capture()->void:
	_capture()


func _on_release()->void:
	_release()
