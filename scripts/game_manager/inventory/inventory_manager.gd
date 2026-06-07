class_name InventoryManager
extends RefCounted

signal values_changed

#resource id & amount
var inventory : Dictionary[String,int] = {}

func add(id:String,amount:int)->void:
	inventory.get_or_add(id,0)
	inventory[id]+=amount
	values_changed.emit()


func remove(id:String,amount:int)->bool:
	if amount > get_amount(id):
		return false
	
	inventory[id] -= amount
	values_changed.emit()
	return true


func get_amount(id:String)->int:
	if not inventory.has(id):
		return -1
	return inventory[id]
