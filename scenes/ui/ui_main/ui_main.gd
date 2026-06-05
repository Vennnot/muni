class_name UIMain
extends Control

@onready var close_button: UITextureButton = %CloseButton
@onready var settings_button: UITextureButton = %SettingsButton


@onready var settings_container: VBoxContainer = %SettingsContainer

func _ready() -> void:
	Global.ui_toggled.connect(_on_ui_toggled)
	close_button.pressed.connect(func():get_tree().quit())
	settings_button.pressed.connect(_on_settings_button_pressed)


func _on_ui_toggled(is_open:bool)->void:
	visible = is_open


func _on_settings_button_pressed()->void:
	hide_containers()
	settings_container.show()


func hide_containers()->void:
	settings_container.hide()

#TODO
#change clamp borders/usable screen, so it only takes for example,
#90% of screen horizontally
