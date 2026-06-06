class_name InventoryManager
extends RefCounted

signal values_changed

#resource id & amount
var inventory : Dictionary[int,int] = {}

func add(id:int,amount:int)->void:
	inventory.get_or_add(id,0)
	inventory[id]+=amount
	values_changed.emit()


func remove(id:int,amount:int)->bool:
	if amount > get_amount(id):
		return false
	
	inventory[id] -= amount
	values_changed.emit()
	return true


func get_amount(id:int)->int:
	if not inventory.has(id):
		return -1
	return inventory[id]
