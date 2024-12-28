extends Node2D

func _ready() -> void:
	PolarTimer.timeout.connect(self.on_polar_timer_timeout)

func on_polar_timer_timeout() -> void:
	pass   
