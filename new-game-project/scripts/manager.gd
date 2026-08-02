extends Node
@onready var marker_2d: Marker2D = $Marker2D

@onready var timer: Timer = $Timer
var pipe = preload("res://scenes/pipes.tscn")
var game_over_screen = preload("res://scenes/game_over_screen.tscn")
var rng = RandomNumberGenerator.new()

enum playmodes {NORMAL, DASH, IFRAMES, DEATH}
@export var playmode = playmodes.NORMAL

func _ready() -> void:
	Globals.death.connect(death_scene)
	Globals.dash.connect(dashing)
	Globals.dash_stop.connect(stop_dashing)

func _on_timer_timeout() -> void:
	var spawn_pipe = pipe.instantiate()
	spawn_pipe.position.x = marker_2d.position.x
	spawn_pipe.position.y = rng.randi_range(150, 500)
	add_child(spawn_pipe)
	
func dashing():
	playmode = playmodes.DASH
	Engine.time_scale = 4

func stop_dashing():
	playmode = playmodes.NORMAL
	Engine.time_scale = 1

func death_scene():
	playmode = playmodes.DEATH
	add_child(game_over_screen.instantiate())
	get_tree().paused = true
