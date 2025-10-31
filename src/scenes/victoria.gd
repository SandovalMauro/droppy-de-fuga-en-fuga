extends Control

class_name Victoria
signal restart


func _on_exit_button_pressed() -> void:
		get_tree().quit()


func _on_restart_button_pressed() -> void:
	restart.emit()
