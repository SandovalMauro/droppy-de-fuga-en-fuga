extends Node

@export_file_path("*.tscn") var level_path: String
@export_file_path("*.tscn") var main_menu_scene_path: String


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(level_path)


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_scene_path)


func _on_exit_button_pressed() -> void:
	get_tree().quit()
