class_name UI
extends CanvasLayer

@onready var button: Button = $Button
func get_all_global_rects()->Rect2:
	return button.get_global_rect()
