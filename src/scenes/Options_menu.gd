extends Control

@export var level: PackedScene
@onready var audio_configuration: Control = $AudioConfiguration
@onready var audio_manager: Node2D = $AudioManager


func _on_start_button_pressed() -> void:
	audio_manager.get_node("menu_music").play()
	get_tree().change_scene_to_packed(level)


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_audio_button_pressed() -> void:
	audio_configuration.show()
