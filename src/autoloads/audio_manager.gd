extends Node

@onready var gun_shoot: AudioStreamPlayer = $SFX/Player/GunShoot
@onready var hp_pickup: AudioStreamPlayer = $SFX/Player/HpPickup
@onready var level_up: AudioStreamPlayer = $SFX/Player/LevelUp
@onready var xp_pickup: AudioStreamPlayer = $SFX/Player/XpPickup
@onready var player_dash: AudioStreamPlayer = $SFX/Player/PlayerDash
@onready var player_transform: AudioStreamPlayer = $SFX/Player/PlayerTransform
@onready var enemy_hit: AudioStreamPlayer = $SFX/Enemy/EnemyHit
@onready var stream: AudioStreamPlayer = $SFX/Game/Stream
@onready var button_hover: AudioStreamPlayer = $SFX/Game/ButtonHover
@onready var button_press: AudioStreamPlayer = $SFX/Game/ButtonPress
@onready var pause: AudioStreamPlayer = $SFX/Game/Pause
@onready var pre_song: AudioStreamPlayer = $Music/PreSong
@onready var main_song: AudioStreamPlayer = $Music/MainSong

func play_main_theme() -> void:
	if main_song.playing:
		return
	main_song.play()
	pre_song.stop()
