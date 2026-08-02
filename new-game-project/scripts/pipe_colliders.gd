extends Area2D

@onready var pipe_animation: AnimationPlayer = $"../pipe animation"

func _on_body_entered(body: Node2D) -> void:
	Globals.death.emit()
