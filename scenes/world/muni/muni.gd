class_name Muni
extends Node2D

const SPEED: float = 20.0

@onready var sprite: Sprite2D = %Sprite

var _moving_to_target : bool = false

var target_resource : Node2D :
	set(value):
		target_resource = value
		_moving_to_target = true


func _move_to_target(delta: float) -> void:
	if not _moving_to_target or not target_resource:
		return
	var target_pos := target_resource.global_position
	var muni_size: float = sprite.get_rect().size.x/1.1
	var dir: float = sign(target_pos.x - global_position.x)
	var stop_pos: float = target_pos.x - dir * muni_size
	position.x += dir * SPEED * delta
	if abs(position.x - stop_pos) <= SPEED * delta:
		position.x = stop_pos
		_moving_to_target = false

func _physics_process(delta: float) -> void:
	_move_to_target(delta)
