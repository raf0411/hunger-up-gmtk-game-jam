class_name Trampoline
extends RigidBody2D

@export var BOUNCE_FORCE: float = -250.0
@export var one_way_collision: bool = false

@onready var collision_shape_2d = $CollisionShape2D
@onready var bounce_sfx = $BounceSFX

func _ready():
	gravity_scale = 0
	collision_shape_2d.one_way_collision = one_way_collision

func _on_jump_area_body_entered(body):
	if body is Player and body.is_fat:
		gravity_scale = 1
	elif body is Player and body.has_method("bounce") and not body.is_fat:
		body.bounce(BOUNCE_FORCE)
		bounce_sfx.play()
