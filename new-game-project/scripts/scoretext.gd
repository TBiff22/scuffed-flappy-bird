extends RichTextLabel

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Globals.despawn_score_text.connect(despawner)

func despawner():
	queue_free()
