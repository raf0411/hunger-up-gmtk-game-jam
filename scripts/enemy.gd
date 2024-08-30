class_name Enemy
extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var wall_detector = $WallDetector

@export var SPEED: float = 100.0
@export var direction: int = 1

var was_collided: bool = false

func _ready():
	animation_player.play("idle")

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.rotate(PI)
		was_collided = true
	else:
		was_collided = false
	
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = true
	
	move_and_slide()

func drop_key():
	var KEY := preload("res://scenes/key.tscn")
	var key := KEY.instantiate()
	key.position = global_position
	
	get_parent().add_child(key)

func _on_health_component__on_died_event_handler():
	call_deferred("drop_key")
	self.queue_free()
