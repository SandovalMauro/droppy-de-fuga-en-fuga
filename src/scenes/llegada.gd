extends Node2D

@onready var timer: Timer = $Timer
@onready var audio_manager: Node2D = $"../AudioManager"

var victoria: Node = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Droppy:
		audio_manager.get_node("victory_sound").play()
		timer.start()

func _on_timer_timeout() -> void:
	# En vez de cambiar toda la escena, mostramos Victoria
	if victoria:
		victoria.visible = true
		victoria.set_process(true)
		victoria.get_child(0).visible = true
	else:
		var v = get_node("Victoria")
		v.visible = true
		v.set_process(true)
		v.get_child(0).visible = true
