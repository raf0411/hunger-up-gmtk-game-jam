class_name Player
extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var bullet_position = $BulletPosition
@onready var shoot_sfx = $ShootSFX
@onready var hurt_sfx = $HurtSFX
@onready var death_sfx = $DeathSFX
@onready var powerup_sfx = $PowerupSFX
@onready var powerdown_sfx = $PowerdownSFX

@export var movement_stats : MovementStats
@export var is_fat: bool = false
@export var scale_value: float = 1.5

var has_key: bool = false
var can_shoot: bool = false
var is_facing_right: bool = true
var is_facing_left: bool = false

func _ready():
	movement_stats.SPEED = 20.0
	animated_sprite_2d.play("idle")
	
	if is_fat:
		scale_up()

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	apply_gravity(delta)
	apply_acceleration(direction, delta)
	apply_friction(direction, delta)
	move_and_slide()
	
	shoot()
	
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
		bullet_position.position.x = -7
		is_facing_left = true
		is_facing_right = false
	elif velocity.x > 0:
		animated_sprite_2d.flip_h = false
		bullet_position.position.x = 7
		is_facing_left = false
		is_facing_right = true
	
	if is_on_floor():
		animated_sprite_2d.play("idle")
	elif not is_on_floor():
		animated_sprite_2d.play("jump")

	collision_shape_2d.scale.x = 1

func apply_acceleration(direction: float, _delta: float):
	if direction:
		velocity.x = move_toward(velocity.x, 
					 movement_stats.SPEED * direction,
					 movement_stats.ACCELERATION)

func apply_friction(direction: float, _delta: float):
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, 
					 movement_stats.FRICTION)

func apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y += movement_stats.GRAVITY * delta * movement_stats.GRAVITY_SCALE

func collect_food(food: FoodResource):
	if food.type == "Sweets":
		scale_up()
	elif food.type == "Healthy":
		scale_down()

func bounce(bounce_force: float):
	velocity.y = bounce_force

func shoot():
	if Input.is_action_just_released("shoot") and can_shoot and is_facing_right:
		var BULLET := preload("res://scenes/bullet.tscn")
		var bullet := BULLET.instantiate()
		bullet.position = bullet_position.global_position
		bullet.BULLET_FORCE = 70.0
		get_parent().add_child(bullet)
		shoot_sfx.play()

	if Input.is_action_just_released("shoot") and can_shoot and is_facing_left:
		var BULLET := preload("res://scenes/bullet.tscn")
		var bullet := BULLET.instantiate()
		bullet.position = bullet_position.global_position
		bullet.BULLET_FORCE = -70.0
		get_parent().add_child(bullet)
		shoot_sfx.play()

func scale_up():
	powerup_sfx.play()	
	if scale >= Vector2(scale_value, scale_value):
		return
	scale *= scale_value
	if scale >= Vector2(1,1) * scale_value:
		is_fat = true

func scale_down():
	powerdown_sfx.play()
	#if scale <= Vector2(1, 1):
		#return
	scale /= scale_value
	if scale <= Vector2(1,1):
		is_fat = false

func power_up():
	can_shoot = true

func collect_key():
	has_key = true

func _on_health_component__on_died_event_handler():
	death_sfx.play()
	collision_shape_2d.set_deferred("disabled", true)
	movement_stats.SPEED = 0
	await death_sfx.finished
	get_tree().call_deferred("reload_current_scene")
