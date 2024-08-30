extends Area2D

@onready var death_sfx = $DeathSFX

func _on_body_entered(body):
	if body is Player:
		GlobalStats.death_count += 1
		death_sfx.play()
		await  death_sfx.finished
		get_tree().call_deferred("reload_current_scene")
