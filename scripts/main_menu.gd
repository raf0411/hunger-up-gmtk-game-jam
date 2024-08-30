extends CanvasLayer

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var animation_player = %AnimationPlayer
@onready var animation_player_2 = %AnimationPlayer2
@onready var settings_menu = %SettingsMenu
@onready var menu = %Menu
@onready var deaths_label = %DeathsLabel
@onready var close_sfx = $CloseSFX
@onready var press_sfx = $PressSFX
@onready var music = $Music

func _ready():
	get_tree().paused = false
	music.play()
	deaths_label.text = "Deaths: " + str(GlobalStats.death_count)
	animation_player.play("flying_character_menu")
	animation_player_2.play("key_flying")

func _on_play_pressed():
	press_sfx.play()
	await press_sfx.finished
	get_tree().call_deferred("change_scene_to_file", 
							 "res://scenes/levels/level_1.tscn")

func _on_exit_pressed():
	close_sfx.play()
	await close_sfx.finished
	get_tree().call_deferred("quit")

func _on_back_pressed():
	close_sfx.play()
	settings_menu.visible = false
	menu.visible = true

func _on_settings_pressed():
	press_sfx.play()
	settings_menu.visible = true
	menu.visible = false

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)
