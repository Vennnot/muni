class_name InventoryContainer
extends VBoxContainer

@onready var label_2: Label = $Label2

var inventory : Dictionary[String,int]

func _ready() -> void:
	Global.game_manager.inventory.values_changed.connect(_on_values_changed)
	inventory = Global.game_manager.inventory.inventory
	_on_values_changed()

func _on_values_changed()->void:
	label_2.text = str(inventory)
