extends CanvasLayer

#@export var menu: PackedScene
@export_file_path("*.tscn") var main_menu_scene_path: String
@onready var audio_manager: Node2D = $"../AudioManager"

func _ready() -> void:
	self.hide()

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	self.hide()
	

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(main_menu_scene_path)
	

func _on_exit_button_pressed() -> void:
	get_tree().quit()
