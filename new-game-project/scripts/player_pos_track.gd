extends Marker2D
@onready var player: CharacterBody2D = $player


func _process(float) -> void:
	position = player.position
