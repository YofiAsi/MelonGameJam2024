extends Node2D

@onready var movement2d: Movement2D = $Movement2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var dead: bool = false

func _process(delta: float) -> void:
	if self.dead:
		return
	if not movement2d:
		return
	movement2d.move_direction(self.global_position.direction_to(Global.player.global_position))

func sprite_flash() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(animated_sprite, "modulate:r", 1, 0.25).from(15)

func _on_hurtbox_2d_hurt_signal() -> void:
	self.sprite_flash()

func _on_hurtbox_2d_death_signal() -> void:
	self.animated_sprite.play("death")
	self.dead = true
	movement2d.queue_free()
	$DeathQueueTimer.start()

func _on_death_queue_timer_timeout() -> void:
	self.queue_free()
