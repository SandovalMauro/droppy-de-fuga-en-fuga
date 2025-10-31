extends Control

@onready var slider_volumen: HSlider = $VBoxContainer/Volume/HSlider
@onready var check_musica: CheckBox = $VBoxContainer/SwitchMusic/CheckBoxMusic
@onready var check_sfx: CheckBox = $VBoxContainer/SwitchSFX/CheckBoxSFX
@onready var audio_manager: Node2D = $AudioManager

func _ready():
	slider_volumen.value = audio_manager.music_vol
	check_musica.button_pressed = !audio_manager.music_mute
	check_sfx.button_pressed = !audio_manager.sfx_mute


func _on_h_slider_value_changed(value: float) -> void:
	audio_manager.set_music_volume(value)
	audio_manager.save_settings()


func _on_check_box_sfx_toggled(toggled_on: bool) -> void:
	audio_manager.toggle_sfx_mute(toggled_on)
	audio_manager.save_settings()


func _on_check_box_music_toggled(toggled_on: bool) -> void:
	audio_manager.toggle_music_mute(toggled_on)
	audio_manager.save_settings()


func _on_volver_pressed() -> void:
		hide()
