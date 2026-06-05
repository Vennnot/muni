class_name UIToggleButton
extends UIDraggable

func _ready() -> void:
	super._ready()
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	Global.toggle_ui()
