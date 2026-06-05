class_name AdjustableValueContainer
extends HBoxContainer

signal back_pressed
signal next_pressed

@onready var back_button: Button = %BackButton
@onready var value_label: Label = %ValueLabel
@onready var next_button: Button = %NextButton


func _ready() -> void:
	back_button.pressed.connect(back_pressed.emit)
	next_button.pressed.connect(next_pressed.emit)


func disable()->void:
	back_button.disabled = true
	next_button.disabled = true


func enable()->void:
	back_button.disabled = false
	next_button.disabled = false
