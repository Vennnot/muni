class_name SettingsContainer
extends VBoxContainer

@onready var adjust_display: AdjustableValueContainer = %AdjustDisplay

@onready var adjust_world_scale: AdjustableValueContainer = %AdjustWorldScale
@onready var scale_check_box: CheckBox = %ScaleCheckBox


var available_screens : int


func _ready() -> void:
	ScreenHelper.screen_changed.connect(_on_screen_changed)
	ScreenHelper.world_scale_changed.connect(_on_world_scale_changed)
	available_screens = DisplayServer.get_screen_count()-1
	
	adjust_display.back_button.pressed.connect(_on_display_back_pressed)
	adjust_display.next_button.pressed.connect(_on_display_next_pressed)
	
	adjust_world_scale.back_button.pressed.connect(_on_world_back_pressed)
	adjust_world_scale.next_button.pressed.connect(_on_world_next_pressed)
	scale_check_box.toggled.connect(_on_scale_checkbox_toggled)
	adjust_world_scale.disable()
	
	_on_screen_changed()
	_on_world_scale_changed()

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
func _on_scale_checkbox_toggled(toggled_on:bool)->void:
	ScreenHelper.allow_manual_scaling = toggled_on
	if toggled_on:
		adjust_world_scale.enable()
	else:
		adjust_world_scale.disable()


func _on_world_back_pressed()->void:
	ScreenHelper.manual_scale-=1


func _on_world_next_pressed()->void:
	ScreenHelper.manual_scale += 1


func _on_world_scale_changed()->void:
	scale_check_box.button_pressed = ScreenHelper.allow_manual_scaling
	adjust_world_scale.value_label.text = str(ScreenHelper.get_integer_scale())

#endregion
