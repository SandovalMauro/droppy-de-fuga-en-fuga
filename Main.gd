extends Node

func _ready() -> void:
	Engine.time_scale = 0

func _on_start_start_game() -> void:
	Engine.time_scale = 1
