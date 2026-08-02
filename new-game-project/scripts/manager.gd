extends Node
@onready var marker_2d: Marker2D = $Marker2D

var pipe = preload("res://scenes/pipes.tscn")
var game_over_screen = preload("res://scenes/game_over_screen.tscn")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	Globals.death.connect(death_scene)

func _on_timer_timeout() -> void:
	var spawn_pipe = pipe.instantiate()
	spawn_pipe.position.x = marker_2d.position.x
	spawn_pipe.position.y = rng.randi_range(150, 500)
	print(spawn_pipe.position.y)
	add_child(spawn_pipe)

func death_scene():
	add_child(game_over_screen.instantiate())
	get_tree().paused = true
