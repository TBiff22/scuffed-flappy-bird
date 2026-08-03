extends Area2D



func _on_body_entered(body: Node2D) -> void:
	Globals.point_add.emit()
	queue_free()
