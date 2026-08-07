extends Control



func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_game_scene.tscn")


func _on_instructions_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/instructions.tscn")
