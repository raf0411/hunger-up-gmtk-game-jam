extends Area2D

@export var health_component: HealthComponent
@export var character: CharacterBody2D

func _on_area_entered(area):
	if area is HitboxComponent:
		health_component.take_damage(area.damage)
