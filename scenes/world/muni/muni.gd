class_name Muni
extends Node2D

var _direction: float = 1.0
var _timer: float = 0.0
var _interval: float = 1.0
const SPEED: float = 100.0

func _physics_process(delta: float) -> void:
	return
	_timer += delta
	if _timer >= _interval:
		_timer = 0.0
		_interval = randf_range(0.5, 2.0)
		_direction = [-1.0, 1.0].pick_random()
	position.x += _direction * SPEED * delta
