class_name UIToggleButton
extends UIDraggable

var base_size := Vector2(32,32)

func _ready() -> void:
	super._ready()
	ScreenHelper.ui_scale_changed.connect(_on_ui_scale_changed)
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	Global.toggle_ui()


func _on_ui_scale_changed(ui_scale:float)->void:
	size = base_size*ui_scale
