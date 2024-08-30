class_name Gate
extends StaticBody2D

@onready var unlocked_sfx = $UnlockedSFX

func _on_player_detector_body_entered(body):
	if body is Player and body.has_key:
		body.has_key = false
		unlocked_sfx.play()
		await unlocked_sfx.finished
		queue_free()
