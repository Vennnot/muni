class_name SettingsContainer
extends VBoxContainer

@onready var adjust_display: AdjustableValueContainer = %AdjustDisplay

@onready var adjust_world_scale: AdjustableValueContainer = %AdjustWorldScale
@onready var scale_check_box: CheckBox = %ScaleCheckBox


var available_screens : int


func _ready() -> void:
	ScreenHelper.screen_changed.connect(_on_screen_changed)
	available_screens = DisplayServer.get_screen_count()-1
	
	adjust_display.back_button.pressed.connect(_on_display_back_pressed)
	adjust_display.next_button.pressed.connect(_on_display_next_pressed)
	
	adjust_world_scale.back_button.pressed.connect(_on_world_back_pressed)
	adjust_world_scale.next_button.pressed.connect(_on_world_next_pressed)
	scale_check_box.pressed.connect(_on_scale_checkbox_pressed)
	adjust_world_scale.disable()
	
	_on_screen_changed()

func _on_display_back_pressed()->void:
	var current_screen := ScreenHelper.current_screen
	if current_screen <= 0:
		return
	ScreenHelper.set_screen(current_screen-1)

func _on_display_next_pressed()->void:
	var current_screen := ScreenHelper.current_screen
	if current_screen >= available_screens:
		return
	ScreenHelper.set_screen(current_screen+1)



func _on_screen_changed()->void:
	adjust_display.value_label.text = str(ScreenHelper.current_screen)


#region world scale
func _on_scale_checkbox_pressed()->void:
	if scale_check_box.pressed:
		adjust_world_scale.enable()
	else:
		adjust_world_scale.disable()


func _on_world_back_pressed()->void:
	pass


func _on_world_next_pressed()->void:
	pass
#endregion
