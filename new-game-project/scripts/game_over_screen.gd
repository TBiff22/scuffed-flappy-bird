extends Control

@onready var result_text: RichTextLabel = $"result text"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if Globals.first_play == true:
		Globals.high_score = Globals.score
		Globals.first_play = false
	animation_player.play("loading animation")
	if Globals.score > Globals.high_score:
		result_text.text = "NEW HIGH SCORE!\nYour score: " + str(Globals.score) + "\nYour previous high score: " + str(Globals.high_score)
	else:
		result_text.text = "Your score: " + str(Globals.score) + "\nYour high score: " + str(Globals.high_score)
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_replay_button_pressed() -> void:
	if Globals.score > Globals.high_score:
		Globals.high_score = Globals.score
	get_tree().paused = false
	get_tree().reload_current_scene()

func despawner():
	Globals.despawn_score_text.emit()

func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start.tscn")
