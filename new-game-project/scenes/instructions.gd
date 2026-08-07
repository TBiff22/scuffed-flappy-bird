extends Control

func _on_instructions_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start.tscn")
