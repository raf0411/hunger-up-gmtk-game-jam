extends Area2D

@export var next_scene: String

func _on_body_entered(body):
	if body is Player:
		body.movement_stats.SPEED = 0
		TransitionLevel.transition()
		await TransitionLevel.on_transition_finished
		get_tree().call_deferred("change_scene_to_file", next_scene)
