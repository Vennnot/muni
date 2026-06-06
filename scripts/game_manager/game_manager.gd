class_name GameManager
extends RefCounted

var inventory : InventoryManager

func setup()->void:
	inventory = InventoryManager.new()
