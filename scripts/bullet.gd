class_name Bullet
extends Node2D

@export var BULLET_FORCE: float = 70.0

func _process(delta):
	position.x += BULLET_FORCE * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()
