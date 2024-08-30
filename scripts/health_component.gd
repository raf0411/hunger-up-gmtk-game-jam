class_name HealthComponent
extends Node

@export var max_health: int = 5

var current_health: int

signal _on_health_changed
signal _on_died_event_handler

func _ready():
	current_health = max_health

func take_damage(damage: int):
	if current_health <= 1:
		GlobalStats.death_count += 1
		self._on_died_event_handler.emit()
	
	current_health -= damage
	self._on_health_changed.emit()
