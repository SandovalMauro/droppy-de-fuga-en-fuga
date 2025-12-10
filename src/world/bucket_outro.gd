extends Node2D

signal outro_finished

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim_player.animation_finished.connect(_on_animation_finished)

func play_outro() -> void:
	anim_player.play("new_animation")

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "new_animation":
		outro_finished.emit()
