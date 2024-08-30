extends CanvasLayer

@onready var close_sfx = $CloseSFX
@onready var press_sfx = $PressSFX

func _on_restart_pressed():
	press_sfx.play()
	await press_sfx.finished
	get_tree().reload_current_scene()

func _on_exit_pressed():
	close_sfx.play()
	await close_sfx.finished
	get_tree().quit()

func _on_continue_pressed():
	close_sfx.play()
	await close_sfx.finished
	get_tree().paused = false
	visible = false

func _on_main_menu_pressed():
	close_sfx.play()
	await close_sfx.finished
	get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu.tscn")
