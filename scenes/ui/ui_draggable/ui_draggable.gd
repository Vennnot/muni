class_name UIDraggable
extends Button

var _dragging: bool = false
var _drag_offset: Vector2i

func _ready() -> void:
	gui_input.connect(_on_gui_input)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mb := event as InputEventMouseButton
		if mb.button_index == MOUSE_BUTTON_LEFT:
			_dragging = mb.pressed
			_drag_offset = get_window().position - Vector2i(DisplayServer.mouse_get_position())

	if event is InputEventMouseMotion and _dragging:
		get_window().position = Vector2i(DisplayServer.mouse_get_position()) + _drag_offset
