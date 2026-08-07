extends Node
@onready var marker_2d: Marker2D = $Marker2D
@onready var camera_animation: AnimationPlayer = $"camera animation"
@onready var timer: Timer = $Timer
@onready var scoretext: RichTextLabel = $scoretext
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var player_pos_track: Marker2D = $"../player/player_pos_track"

var state_machine = AnimationNodeStateMachinePlayback

var penalty = preload("res://scenes/penalty.tscn")
var explode = preload("res://scenes/explode.tscn")
var pipe = preload("res://scenes/pipes.tscn")
var game_over_screen = preload("res://scenes/game_over_screen.tscn")
var rng = RandomNumberGenerator.new()

enum playmodes {NORMAL, DASH, DEATH}
@export var playmode = playmodes.NORMAL

enum first_dash {YES, NO}
@export var dash_check = first_dash.YES

func _ready() -> void:
	state_machine = animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	Globals.score = 0
	scoretext.text = str(Globals.score)
	Engine.time_scale = 1
	Globals.death.connect(death_scene)
	Globals.dash.connect(dashing)
	Globals.dash_stop.connect(stop_dashing)
	Globals.point_add.connect(add_score)

func add_score():
	if playmode == playmodes.NORMAL:
		Globals.score += 1
	elif playmode == playmodes.DASH:
		Globals.score += 3
	scoretext.text = str(Globals.score)

func _on_timer_timeout() -> void:
	var spawn_pipe = pipe.instantiate()
	spawn_pipe.position.x = marker_2d.position.x
	spawn_pipe.position.y = rng.randi_range(150, 500)
	add_child(spawn_pipe)
	
func dashing():
	playmode = playmodes.DASH
	Engine.time_scale = 4
	state_machine.start("dash_zoom")
	print("dashing")

func stop_dashing():
	Engine.time_scale = 1
	if playmode != playmodes.DEATH:
		state_machine.travel("dash_zoom_out")
		playmode = playmodes.NORMAL
	if dash_check == first_dash.YES:
		dash_check = first_dash.NO

func death_scene():
	if playmode == playmodes.DASH and dash_check == first_dash.YES:
		pass
	else:
		if Globals.dash_death == true:
			Globals.score -= 10
			scoretext.text = str(Globals.score)
			add_child(penalty.instantiate())
			var explosion = explode.instantiate()
			explosion.position = player_pos_track.position
			explosion.scale *= 1.5
			add_child(explosion)
			state_machine.travel("RESET")
		playmode = playmodes.DEATH
		add_child(game_over_screen.instantiate())
		get_tree().paused = true
