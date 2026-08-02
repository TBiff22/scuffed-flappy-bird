extends CharacterBody2D
@onready var manager: Node = $"../manager"

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

func _ready():
	Globals.death.connect(death_player)

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta *1.5
	velocity.x = 0
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
	move_and_slide()

func death_player():
	print("hi - player")
