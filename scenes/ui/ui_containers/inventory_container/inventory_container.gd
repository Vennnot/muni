class_name InventoryContainer
extends VBoxContainer

const ITEM_CONTAINER := preload("uid://0npo73sw1xri")

@onready var item_container: GridContainer = %ItemContainer

var inventory : Dictionary[String,int]

func _ready() -> void:
	Global.game_manager.inventory.values_changed.connect(_on_values_changed)
	inventory = Global.game_manager.inventory.inventory
	_on_values_changed()

func _on_values_changed()->void:
	for c in item_container.get_children():
		c.queue_free()
	


func add_item()->void:
	for i in inventory.keys():
		var item := RDB.get_item_by_id(i)
		
