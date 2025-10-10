extends StaticBody2D

var body_entered: Node2D
signal fall

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Droppy:
		body.hide()
		fall.emit()
