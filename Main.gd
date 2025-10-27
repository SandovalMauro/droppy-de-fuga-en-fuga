extends Node

@export var level: PackedScene

func _ready() -> void:
	#Engine.time_scale = 0
	pass

#func _on_start_start_game() -> void:
	#get_tree().change_scene_to_packed(level)
	##Engine.time_scale = 1


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(level)


func _on_exit_button_pressed() -> void:
	get_tree().quit()
