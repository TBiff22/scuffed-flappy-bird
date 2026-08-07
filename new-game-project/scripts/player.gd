extends CharacterBody2D
@onready var manager: Node = $"../manager"
var gravity_mult = 2

@onready var wingplayer: AnimationPlayer = $wings/wingplayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var jump_sound: AudioStreamPlayer2D = $"jump sound"
@onready var dash_sound: AudioStreamPlayer2D = $"dash sound"
@onready var explode: AudioStreamPlayer2D = $explode
@onready var normal_death: AudioStreamPlayer2D = $"normal death"
@onready var player_pos_track: Marker2D = $player_pos_track

var state_machine = AnimationNodeStateMachinePlayback
var dash_death_scene = false
const SPEED = 300.0
const JUMP_VELOCITY = -800.0

func _ready():
	animation_tree.active = true
	state_machine = animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	process_mode = Node.PROCESS_MODE_ALWAYS
	Globals.death.connect(death_animations)

func _process(float) -> void:
	player_pos_track.position = position

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta * gravity_mult
	velocity.x = 0
	if manager.playmode == manager.playmodes.NORMAL:
		Engine.time_scale = 1
		gravity_mult = 2
		Globals.dash_death = false
		if Input.is_action_just_pressed("jump"):
			jump_sound.play()
			velocity.y = JUMP_VELOCITY
			state_machine.start("jump")
			wingplayer.play("RESET")
			wingplayer.play("wingflap")
		if Input.is_action_just_pressed("dash"):
			Globals.dash.emit()
			dash_sound.play()
		if velocity.y > 0:
			state_machine.travel("fall")
	elif manager.playmode == manager.playmodes.DASH:
		gravity_mult = 0
		velocity.y = 0
		if manager.dash_check == manager.first_dash.YES:
			state_machine.travel("dash_invincible")
		else:
			state_machine.travel("dash_normal")
			Globals.dash_death = true
	elif manager.playmode == manager.playmodes.DEATH:
		if dash_death_scene == true:
			gravity_mult = 2.4
			velocity.x = -400
			rotation_degrees -= 20
		else:
			pass
	move_and_slide()

func stop_dash():
	if manager.playmode != manager.playmodes.DEATH:
		Globals.dash_stop.emit()
		gravity_mult = 2
		
func death_animations():
	if manager.playmode == manager.playmodes.DEATH:
		Engine.time_scale = 1
		if Globals.dash_death == true:
			dash_death_scene = true
			explode.play() 
			state_machine.travel("death_dash")
		elif Globals.dash_death == false:
			normal_death.play()
			scale.y = -scale.y
			velocity.y = JUMP_VELOCITY
			state_machine.travel("death_norma")
