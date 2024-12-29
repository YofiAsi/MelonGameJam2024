extends Node2D

@onready var main_game: GameManager = $GameManager
@onready var pause_menu: CanvasLayer = $PauseMenu

var is_paused: bool = false  # Track pause state

func _ready():
	pause_menu.hide()
	#Global.reset()

func _input(event):
	if event.is_action_pressed("pause"):  # ESC key
		toggle_pause()

func toggle_pause():
	if is_paused:
		unpause_game()
	else:
		pause_game()

func pause_game():
	is_paused = true
	main_game.get_tree().paused = true
	pause_menu.show()
	AudioManager.pause.play()

func unpause_game():
	is_paused = false
	main_game.get_tree().paused = false
	pause_menu.hide()
	AudioManager.pause.play()

func _on_resume_pressed() -> void:
	unpause_game()

func _on_credits_pressed() -> void:
	unpause_game()
	#main_game.go_to_credits()
	
func _on_restart_pressed() -> void:
	unpause_game()
	SceneManager.reload_scene({
		"pattern_enter": "squares",
		"pattern_leave": "squares",
	})
