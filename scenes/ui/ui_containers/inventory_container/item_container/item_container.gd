class_name ItemContainer
extends MarginContainer

@onready var item_texture: TextureRect = %ItemTexture
@onready var amount_label: Label = %AmountLabel

func setup(item:Item, amount:int)->void:
	item_texture.texture = item.texture
	amount_label.text = str(amount)
