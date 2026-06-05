extends Node

signal ui_toggled(is_open:bool)

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
