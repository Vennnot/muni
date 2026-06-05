class_name UIMain
extends Control

@onready var close_button: UITextureButton = %CloseButton
@onready var settings_button: UITextureButton = %SettingsButton


@onready var settings_container: VBoxContainer = %SettingsContainer

func _ready() -> void:
	_store_base_values(self)
	Global.ui_toggled.connect(_on_ui_toggled)
	ScreenHelper.ui_scale_changed.connect(_on_scale_changed)
	close_button.pressed.connect(func():get_tree().quit())
	settings_button.pressed.connect(_on_settings_button_pressed)


func set_ui_scale(s: float) -> void:
	ScreenHelper.ui_scale = s


func _on_scale_changed(s:float)->void:
	_apply_ui_scale(self, s)


func _on_ui_toggled(is_open:bool)->void:
	visible = is_open


func _on_settings_button_pressed()->void:
	hide_containers()
	settings_container.show()


func hide_containers()->void:
	settings_container.hide()

#region ui_scaling

var _base_min_sizes: Dictionary = {}
var _base_font_sizes: Dictionary = {}
var _base_separations: Dictionary = {}

func _store_base_values(node: Node) -> void:
	if node is Control:
		var control := node as Control
		_base_min_sizes[control.get_instance_id()] = control.custom_minimum_size
	if node is Label:
		var label := node as Label
		_base_font_sizes[label.get_instance_id()] = label.get_theme_font_size("font_size") if label.get_theme_font_size("font_size") > 0 else 16
	if node is BoxContainer:
		var box := node as BoxContainer
		_base_separations[box.get_instance_id()] = box.get_theme_constant("separation")
	for child in node.get_children():
		_store_base_values(child)

func _apply_ui_scale(node: Node, ui_scale: float) -> void:
	if node is Control:
		var control := node as Control
		var base: Vector2 = _base_min_sizes.get(control.get_instance_id(), Vector2.ZERO)
		if base != Vector2.ZERO:
			control.custom_minimum_size = base * ui_scale
	if node is Label:
		var label := node as Label
		var base: int = _base_font_sizes.get(label.get_instance_id(), 16)
		label.add_theme_font_size_override("font_size", base * ui_scale)
	if node is BoxContainer:
		var box := node as BoxContainer
		var base: int = _base_separations.get(box.get_instance_id(), 4)
		box.add_theme_constant_override("separation", base * ui_scale)
	for child in node.get_children():
		_apply_ui_scale(child, ui_scale)
#endregion
