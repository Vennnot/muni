class_name CameraWindow
extends Window

@onready var camera: Camera2D = $Camera

var last_position: = Vector2i.ZERO
var velocity: = Vector2i.ZERO

func _ready() -> void:
	# Set the anchor mode to "Fixed top-left"
	# Easier to work with since it corresponds to the window coordinates
	camera.anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	close_requested.connect(queue_free)

func _process(_delta: float) -> void:
	velocity = position - last_position
	last_position = position
	camera.position = get_camera_pos_from_window()

func get_camera_pos_from_window()->Vector2i:
	return position + velocity
