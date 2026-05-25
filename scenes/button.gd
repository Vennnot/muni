extends Button


func _ready() -> void:
	gui_input.connect(aaa)
	pressed.connect(func():print("pressed!"))


func aaa(event:InputEvent)->void:
	if event.is_action_pressed(&"LMB"):
		button_pressed = true
