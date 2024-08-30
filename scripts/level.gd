extends Node2D

@onready var pause_menu = %PauseMenu
@onready var music = $Music

func _ready():
	Engine.max_fps = 60
	get_tree().paused = false
	music.play()
	RenderingServer.set_default_clear_color("darkgreen")

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu.visible = true
		get_tree().paused = true
