extends Node2D

@onready var timer: Timer = $Timer

@export var llegadoNivel : PackedScene

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Droppy:
		timer.start()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_packed(llegadoNivel)
