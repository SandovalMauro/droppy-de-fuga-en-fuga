extends Node
# volúmenes lineales 0..1
@export var master_vol := 1.0
@export var sfx_vol := 1.0
@export var music_mute := false
@export var sfx_mute := false

const MUSIC_BUS := "Music"
const SFX_BUS := "SFX"

func _ready() -> void:
	load_settings()
	_apply_all()

func set_master_volume(v: float) -> void:
	master_vol = clamp(v, 0.0, 1.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(master_vol))

func toggle_music_mute(on: bool) -> void:
	music_mute = on
	AudioServer.set_bus_mute(AudioServer.get_bus_index(MUSIC_BUS), music_mute)

func toggle_sfx_mute(on: bool) -> void:
	sfx_mute = on
	AudioServer.set_bus_mute(AudioServer.get_bus_index(SFX_BUS), sfx_mute)

func _apply_all() -> void:
	set_master_volume(master_vol)
	toggle_music_mute(music_mute)
	toggle_sfx_mute(sfx_mute)

func save_settings() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("audio","master_vol", master_vol)
	cfg.set_value("audio","music_mute", music_mute)
	cfg.set_value("audio","sfx_mute", sfx_mute)
	cfg.save("user://config.cfg")

func load_settings() -> void:
	master_vol = 0.6
	sfx_vol = 1.0
	music_mute = false
	sfx_mute = false
