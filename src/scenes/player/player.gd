class_name Player extends Node2D

@onready var animation_manager: AnimationManager = $AnimationManager
@onready var gun: Gun360 = $Gun360
@onready var movement_2d: Movement2D = $Movement2D

@onready var hurtbox_big: CollisionShape2D = $Hurtbox2D/Big
@onready var hurtbox_small: CollisionShape2D = $Hurtbox2D/Small

@export var SMALL_BASE_SPEED: int = 400
@export var BIG_BASE_SPEED: int = 300

var curr_state: Global.State:
	set(value):
		if value == curr_state:
			return
		curr_state = value
		animation_manager.switch_state(value)
		gun.disable() if value == Global.State.SMALL else gun.enable()
		hurtbox_big.disabled = value == Global.State.SMALL
		hurtbox_small.disabled = value == Global.State.BIG
		movement_2d.BASE_MAX_SPEED = SMALL_BASE_SPEED if value == Global.State.SMALL else BIG_BASE_SPEED

func _ready() -> void:
	self.curr_state = Global.State.SMALL
	PolarTimer.timeout.connect(self.on_polar_timer_timeout)
	Global.player = self

func _process(delta: float) -> void:
	if self.animation_manager:
		if self.global_position.x < get_global_mouse_position().x:
			self.animation_manager.flip_h = false
		elif self.global_position.x > get_global_mouse_position().x:
			self.animation_manager.flip_h = true
	
	if Input.is_action_just_pressed("dash"):
		movement_2d.dash(1000)

func on_polar_timer_timeout() -> void:
	if self.curr_state == Global.State.SMALL:
		self.curr_state = Global.State.BIG
	else:
		self.curr_state = Global.State.SMALL
