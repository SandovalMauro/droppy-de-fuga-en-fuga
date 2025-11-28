extends Node2D

@export var temp: float;
@onready var timer: Timer = $Timer
@onready var audio_manager: Node2D = $"../AudioManager"

var body_entered: Node2D = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("update_mass"):
		if temp < 0:
			audio_manager.get_node("water_sound").play()
		elif temp > 0:
			audio_manager.get_node("burn_sound").play()
		body_entered = body
		timer.start()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == body_entered:
		if temp < 0:
			audio_manager.get_node("water_sound").stop()
		elif temp > 0:
			audio_manager.get_node("burn_sound").stop()
		timer.stop()
		body_entered = null

func _on_timer_timeout() -> void:
	if body_entered and body_entered.has_method("update_mass"):
		body_entered.update_mass(temp)
