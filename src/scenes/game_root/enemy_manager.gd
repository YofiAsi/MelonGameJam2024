class_name EnemyManager extends Node

@onready var path: Path2D = $Path2D
@onready var follow: PathFollow2D = $Path2D/PathFollow2D
@onready var spawn_timer: Timer = $SpawnTimer

@export var enemies: Array

func _process(delta: float) -> void:
	pass

func _ready() -> void:
	spawn_timer.start()

func pick_random_position() -> Vector2:
	self.follow.progress_ratio = randf()
	return self.follow.global_position

func spawn_enemy() -> void:
	var new_enemy_node: Node2D = enemies.pick_random().instantiate()
	new_enemy_node.global_position = self.pick_random_position()
	
	self.add_child(new_enemy_node)

func spawn_enemies(amount: int) -> void:
	for index in amount:
		self.spawn_enemy()


func _on_spawn_timer_timeout() -> void:
	spawn_enemies(10)
