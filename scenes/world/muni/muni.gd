class_name Muni
extends Node2D

signal target_requested

@onready var sprite: Sprite2D = %Sprite

var busy : bool = false

var target_resource : Node2D :
	set(value):
		target_resource = value
		if target_resource:
			target_resource.muni = self
			_reached_target = false


func _interact()->void:
	if target_resource:
		target_resource.interact()


func unassign_resource()->void:
	target_resource = null


func _physics_process(delta: float) -> void:
	if busy:
		return
	elif target_resource and not _reached_target:
		_move_to_target(delta)
	else:
		_roam(delta)


#region movement
const SPEED: float = 20.0

var _roam_target_x: float = 0.0
var _roam_wait: float = 0.0
var _roaming: bool = false
var _reached_target : bool = false

func _roam(delta: float) -> void:
	if _roam_wait > 0.0:
		_roam_wait -= delta
		return
	if not _roaming:
		_roaming = true
		_roam_target_x = global_position.x + randf_range(-100.0, 100.0)
	var dir: float = sign(_roam_target_x - position.x)
	position.x += dir * SPEED * delta
	if abs(position.x - _roam_target_x) <= SPEED * delta:
		position.x = _roam_target_x
		_roaming = false
		_roam_wait = randf_range(1.0, 3.0)
		if not target_resource:
			target_requested.emit()


func _move_to_target(delta: float) -> void:
	var target_pos := target_resource.global_position
	var muni_size: float = sprite.get_rect().size.x/1.1
	var dir: float = sign(target_pos.x - global_position.x)
	var stop_pos: float = target_pos.x - dir * muni_size
	position.x += dir * SPEED * delta
	if abs(position.x - stop_pos) <= SPEED * delta:
		position.x = stop_pos
		_reached_target = true
		_interact()
#endregion
