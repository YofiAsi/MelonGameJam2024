extends Node2D

@onready var music: HSlider = $MainMenu/VBoxContainer/Music
@onready var sfx: HSlider = $MainMenu/VBoxContainer/SFX

func _ready():
	# Configure the sliders to match the volume range (-30 to 6 dB)
	music.min_value = -30
	music.max_value = 6
	music.value = clamp(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("music")), -30, 6)
	
	sfx.min_value = -30
	sfx.max_value = 6
	sfx.value = clamp(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")), -30, 6)

func _on_button_pressed() -> void:
	if not SceneManager.is_transitioning:
		SceneManager.change_scene(
			"res://src/scenes/game_root/game_root.tscn", {
				"pattern_enter": "squares",
				"pattern_leave": "squares",
			}
		)

func _on_music_value_changed(value: float) -> void:
	if value <= music.min_value:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), -80)  # -inf in dB to mute
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), value)

func _on_sfx_value_changed(value: float) -> void:
	if value <= sfx.min_value:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), -80)  # -inf in dB to mute
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
