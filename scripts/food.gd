class_name Food
extends Area2D

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

@export var food_resource: FoodResource

func _ready():
	sprite_2d.texture = food_resource.texture
	animation_player.play("idle")

func _on_body_entered(body):
	if body.has_method("collect_food"):
		body.collect_food(food_resource)
		queue_free()
