class_name Camera extends Node2D

@export var FOLLOW_DAMPING: float = 0.5
@export var MOUSE_MOVEMENT_SPEED: float = 50.
@export var MAX_MOUSE_MOVEMENT: float = 150.

@export var follow_node: Array[Node2D]

@onready var shaker_component: ShakerComponent2D = $Camera2D/ShakerComponent2D
@onready var phantom_camera_host: PhantomCameraHost = $"Camera2D/PhantomCameraHost"
@onready var phantom_camera: PhantomCamera2D = $PhantomCamera2D

func _ready() -> void:
	phantom_camera.follow_damping_value = Vector2.ONE * FOLLOW_DAMPING
	phantom_camera.follow_target = follow_node[0]

func _process(delta: float) -> void:
	var screen_size = get_viewport_rect().size
	var mouse_position = get_viewport().get_mouse_position()
	var max_screen_distance = screen_size.distance_to(Vector2.ZERO)
	var follow_offset = (mouse_position - (screen_size / 2.)) * MOUSE_MOVEMENT_SPEED / max_screen_distance
	follow_offset = follow_offset.limit_length(MAX_MOUSE_MOVEMENT)

	phantom_camera.follow_offset = follow_offset
