extends Node2D

@export var temp: float;
@onready var timer: Timer = $Timer

var body_entered: Node2D = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("update_temperature"):
		body_entered = body
		timer.start()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == body_entered:
		timer.stop()
		body_entered = null

func _on_timer_timeout() -> void:
	if body_entered and body_entered.has_method("update_temperature"):
		body_entered.update_temperature(temp)
