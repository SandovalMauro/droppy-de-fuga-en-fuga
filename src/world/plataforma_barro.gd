extends Node2D

@onready var audio_manager: Node2D = $"../AudioManager"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Droppy:
		audio_manager.get_node("dirt_sound").play()
		body.speed *= 0.4
		body.linear_velocity *= 0.3

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Droppy:
		body.speed = 250
		audio_manager.get_node("dirt_sound").stop()
