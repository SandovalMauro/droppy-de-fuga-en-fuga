extends Node
# volúmenes lineales 0..1
@export var music_vol := 1.0
@export var sfx_vol := 1.0
@export var music_mute := false
@export var sfx_mute := false

const MUSIC_BUS := "Music"
const SFX_BUS := "SFX"

func _ready() -> void:
	load_settings()
	_apply_all()

func set_music_volume(v: float) -> void:
	music_vol = clamp(v, 0.0, 1.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(MUSIC_BUS), linear_to_db(music_vol))

func set_sfx_volume(v: float) -> void:
	sfx_vol = clamp(v, 0.0, 1.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(SFX_BUS), linear_to_db(sfx_vol))

func toggle_music_mute(on: bool) -> void:
	music_mute = on
	AudioServer.set_bus_mute(AudioServer.get_bus_index(MUSIC_BUS), music_mute)

func toggle_sfx_mute(on: bool) -> void:
	sfx_mute = on
	AudioServer.set_bus_mute(AudioServer.get_bus_index(SFX_BUS), sfx_mute)

func _apply_all() -> void:
	set_music_volume(music_vol)
	set_sfx_volume(sfx_vol)
	toggle_music_mute(music_mute)
	toggle_sfx_mute(sfx_mute)

func save_settings() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("audio","music_vol", music_vol)
	cfg.set_value("audio","sfx_vol", sfx_vol)
	cfg.set_value("audio","music_mute", music_mute)
	cfg.set_value("audio","sfx_mute", sfx_mute)
	cfg.save("user://config.cfg")

func load_settings() -> void:
	var cfg := ConfigFile.new()
	if cfg.load("user://config.cfg") == OK:
		music_vol = float(cfg.get_value("audio","music_vol", 1.0))
		sfx_vol = float(cfg.get_value("audio","sfx_vol", 1.0))
		music_mute = bool(cfg.get_value("audio","music_mute", false))
		sfx_mute = bool(cfg.get_value("audio","sfx_mute", false))
