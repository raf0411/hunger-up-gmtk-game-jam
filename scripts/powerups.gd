extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var powerup_sfx = $PowerupSFX

func _ready():
	animation_player.play("idle")

func _on_body_entered(body):
	if body is Player and body.has_method("power_up"):
		body.power_up()
		powerup_sfx.play()
		await powerup_sfx.finished
		queue_free()
