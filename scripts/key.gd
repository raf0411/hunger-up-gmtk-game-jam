class_name Key
extends Area2D

@onready var key_sfx = $KeySFX

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("idle")

func _on_body_entered(body):
	if body.has_method("collect_key"):
		body.collect_key()
		key_sfx.play()
		await  key_sfx.finished
		queue_free()
