extends AnimatedSprite2D


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	play("default")
	if is_playing() == false:
		queue_free()
