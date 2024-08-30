extends CanvasLayer

@onready var close_sfx = $CloseSFX
@onready var press_sfx = $PressSFX
@onready var music = $Music

func _ready():
	music.play()

func _on_menu_pressed():
	press_sfx.play()
	await press_sfx.finished
	get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu.tscn")

func _on_exit_pressed():
	close_sfx.play()
	await close_sfx.finished
	get_tree().quit()
