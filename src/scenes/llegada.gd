extends Node2D

@onready var timer: Timer = $Timer
@onready var audio_manager: Node2D = $"../AudioManager"
signal finished_level

var victoria: Node = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Droppy:
		body.desactivar_movimiento()
		audio_manager.get_node("victory_sound").play()
		timer.start()

func _on_timer_timeout() -> void:
	finished_level.emit()
	
