class_name Player extends Node2D

@onready var animation_manager: AnimationManager = $AnimationManager
@onready var gun: Gun360 = $Gun360
@onready var movement_2d: Movement2D = $Movement2D

var curr_state: Global.State = Global.State.SMALL

func _ready() -> void:
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
		animation_manager.switch_state(Global.State.BIG)
		gun.enable()
	else:
		self.curr_state = Global.State.SMALL
		animation_manager.switch_state(Global.State.SMALL)
		gun.disable()
