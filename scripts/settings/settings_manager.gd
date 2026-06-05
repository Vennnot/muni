class_name SettingsManager
extends RefCounted

const SAVE_PATH: String = "user://settings.cfg"
const DISPLAY: String = "display"

var _config: ConfigFile = ConfigFile.new()

func _initialize() -> void:
	_connect_signals()
	var error: Error = _config.load(SAVE_PATH)
	if error == OK:
		load_settings()
		return

	_config.set_value(DISPLAY, "screen", 0)
	_config.save(SAVE_PATH)


func load_settings() -> void:
	ScreenHelper.set_screen(_config.get_value(DISPLAY, "screen", 0))


#
#func settings_value_changed(value:float,slider:String)->void:
	#_config.set_value(SETTINGS, slider, value)
	#_config.save(SAVE_PATH)
	#set_volume(slider)
#
#
#func set_volume(slider:String)->void:
	#var bus_index: int = AudioServer.get_bus_index(slider)
	#var volume: float = _config.get_value("settings", slider, 0.0)
	#AudioServer.set_bus_volume_db(bus_index,linear_to_db(volume))


func _connect_signals()->void:
	ScreenHelper.screen_changed.connect(_on_screen_changed)


func _on_screen_changed()->void:
	_config.set_value(DISPLAY, "screen", ScreenHelper.current_screen)
	_config.save(SAVE_PATH)
