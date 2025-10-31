extends Node

@export var level: PackedScene
@onready var audio_manager: Node2D = $AudioManager
@onready var audio_configuration: Control = $MainMenu/OptionsMenu/AudioConfiguration

func _ready():
	audio_manager.get_node("menu_music").play()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(level)


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_audio_pressed() -> void:
	audio_configuration.show()
