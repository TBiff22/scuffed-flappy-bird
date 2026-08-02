extends CharacterBody2D
@onready var manager: Node = $"../manager"
@onready var player_animations: AnimationPlayer = $player_animations
var gravity_mult = 1.5
var dashed = false

const SPEED = 300.0
const JUMP_VELOCITY = -550.0

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta * gravity_mult
	velocity.x = 0
	if manager.playmode == manager.playmodes.NORMAL:
		gravity_mult = 1.5
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
		if Input.is_action_just_pressed("dash"):
			Globals.dash.emit()
			if dashed == false:
				player_animations.play("dash_invincible")
				dashed = true
			else:
				player_animations.play("dash_normal")
	elif manager.playmode == manager.playmodes.DASH:
		gravity_mult = 0
		velocity.y = 0
	move_and_slide()

func stop_dash():
	Globals.dash_stop.emit()
