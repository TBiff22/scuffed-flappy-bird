extends RichTextLabel

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	modulate.a -= 1 * delta
