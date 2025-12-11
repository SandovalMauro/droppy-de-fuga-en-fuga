extends Control

@export_file_path("*.tscn") var main_menu_scene_path: String
@onready var audio_manager: Node2D = $AudioManager

func _ready():
	audio_manager.get_node("menu_music").play()

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_scene_path)
