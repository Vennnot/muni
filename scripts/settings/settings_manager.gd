class_name SettingsManager
extends RefCounted

const SAVE_PATH: String = "user://settings.cfg"
const DISPLAY: String = "display"

const SCREEN: String = "screen"
const WORLD_SCALE: String = "world_scale"
const UI_SCALE: String = "ui_scale"

var _config: ConfigFile = ConfigFile.new()

func _initialize() -> void:
	_connect_signals()
	var error: Error = _config.load(SAVE_PATH)
	if error == OK:
		load_settings()
		return

	_config.set_value(DISPLAY, SCREEN, 0)
	_config.set_value(DISPLAY, WORLD_SCALE, 0)
	_config.set_value(DISPLAY, UI_SCALE, 1)
	_config.save(SAVE_PATH)


func load_settings() -> void:
	ScreenHelper.set_screen(_config.get_value(DISPLAY, SCREEN, 0))
	ScreenHelper.ui_scale = _config.get_value(DISPLAY, UI_SCALE, 1)
	var manual_scale :int=_config.get_value(DISPLAY, WORLD_SCALE, 3)
	if manual_scale > 0:
		ScreenHelper.allow_manual_scaling = true
		ScreenHelper.manual_scale = manual_scale


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
	ScreenHelper.ui_scale_changed.connect(_on_ui_scale_changed)
	ScreenHelper.screen_changed.connect(_on_screen_changed)
	ScreenHelper.world_scale_changed.connect(_on_world_scaling_changed)


func _on_ui_scale_changed(scale:float)->void:
	_config.set_value(DISPLAY, UI_SCALE, scale)
	_config.save(SAVE_PATH)


func _on_screen_changed()->void:
	_config.set_value(DISPLAY, SCREEN, ScreenHelper.current_screen)
	_config.save(SAVE_PATH)


func _on_world_scaling_changed()->void:
	var scale := 0
	if ScreenHelper.allow_manual_scaling:
		scale = ScreenHelper.manual_scale
	_config.set_value(DISPLAY, WORLD_SCALE, scale)
	_config.save(SAVE_PATH)
