class_name Muni
extends Node2D

@onready var sprite: Sprite2D = %Sprite


var busy : bool = false

var target_resource : Node2D :
	set(value):
		target_resource = value
		if target_resource:
			target_resource.muni = self
			_moving_to_target = true

func _interact()->void:
	if target_resource:
		target_resource.interact()

func unassign_resource()->void:
	target_resource = null

func _physics_process(delta: float) -> void:
	if busy:
		return
	if _moving_to_target:
		_move_to_target(delta)
	else:
		_roam(delta)


#region movement
const SPEED: float = 20.0

var _moving_to_target : bool = false
var _roam_target_x: float = 0.0
var _roam_wait: float = 0.0
var _roaming: bool = false

func _roam(delta: float) -> void:
	if _roam_wait > 0.0:
		_roam_wait -= delta
		return
	if not _roaming:
		_roaming = true
		_roam_wait = randf_range(3.0, 15.0)
		_roam_target_x = global_position.x + randf_range(-100.0, 100.0)
	var dir: float = sign(_roam_target_x - position.x)
	position.x += dir * SPEED * delta
	if abs(position.x - _roam_target_x) <= SPEED * delta:
		position.x = _roam_target_x
		_roaming = false

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
		_interact()
#endregion
