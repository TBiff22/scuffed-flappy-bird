extends Control


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_replay_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
