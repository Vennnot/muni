extends Node

signal ui_toggled(is_open:bool)
signal finished_setup

enum LOCATION {home, forest}
enum SKILL {none, mining, stonework}

var settings_manager : SettingsManager
var game_manager : GameManager
var location : LOCATION = LOCATION.forest

var skill : SKILL = SKILL.mining

func _ready() -> void:
	settings_manager = SettingsManager.new()
	settings_manager._initialize()
	
	game_manager = GameManager.new()
	game_manager.setup()
	finished_setup.emit()

var ui_open := false :
	set(value):
		if ui_open == value:
			return
		ui_open = value
		ui_toggled.emit(ui_open)


func toggle_ui()->void:
	ui_open = not ui_open
