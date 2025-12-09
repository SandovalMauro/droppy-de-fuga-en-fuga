extends Node2D

signal intro_finished

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func play_intro():
	anim_player.play("new_animation")

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if anim_name == "new_animation":
		intro_finished.emit()
