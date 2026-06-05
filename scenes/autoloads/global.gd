extends Node

signal ui_toggled(is_open:bool)
signal ui_scale_changed(scale:int)

var ui_scale : int = 1 :
	set(value):
		ui_scale = value
		ui_scale_changed.emit(ui_scale)
var settings_manager : SettingsManager

func _ready() -> void:
	settings_manager = SettingsManager.new()
	settings_manager._initialize()

var ui_open := false :
	set(value):
		if ui_open == value:
			return
		ui_open = value
		ui_toggled.emit(ui_open)


func toggle_ui()->void:
	ui_open = not ui_open
