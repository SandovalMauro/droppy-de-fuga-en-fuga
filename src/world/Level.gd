extends Node
#hacerla abstracta

# temperature_air: temperatura ambiente (°C)
# humidity: humedad relativa (0.0 - 1.0)
# pressure_atm:: presión ambiente (atm)
@export var temperature_air = 22.0 #= 0
@export var humidity = 0.9 #= 0
@export var pressure_atm = 0.9 #= 0

	# Ajustar para calibrar el peso de cada variable
@export var hardLevel: bool
@export var k_presion = 0.5 #0
@export var k_humedad = 0.3 #0
@export var k_Taire = 0.005 #0
@export var k_Tdrop = 0.008 #0

@export var limite_level = 1000000

const K := 0.05  # coeficiente general para ajustar el juego

@export var droppy: Droppy

var level_selector = Level_selector.new()

@onready var audio_manager: Node2D = $AudioManager
@onready var audio_configuration: Control = $Nivel/PauseMenu/AudioConfiguration




func _ready() -> void:
	#temperature_air = 22#30
	#humidity = 0.9#0.5
	#pressure_atm = 0.5 #1
	audio_manager.get_node("music").play()
	droppy.limit_camera(limite_level)

func _physics_process(delta: float) -> void:
	var dm = calcular_estado(droppy.temperature, temperature_air, humidity, pressure_atm, droppy.mass)
	droppy.update_mass(dm * delta)
	
	if Input.is_action_pressed("esq"):
		pause()

func calcular_estado(t_drop: float, t_air: float, hum: float, p_atm: float, m: float) -> float:
	# Referencias que definen el equilibrio
	var T_ref = 20.0   # °C
	var RH_ref = 0.5   # 50%
	var P_ref = 1.0    # atm
	
	# Calculo, resto el valor de equilibrio a los pasados por parametro y multiplico por el peso
	var w_presion
	var w_humedad
	var w_Taire
	var w_Tdrop
	var dm_dt

	if hardLevel:
		w_presion = k_presion * (p_atm - P_ref)
		w_humedad = k_humedad * (hum - RH_ref)
		w_Taire   = -k_Taire * (t_air - T_ref)
		w_Tdrop   = -k_Tdrop * (t_drop - T_ref)
		# Calculo el cambio masa
		dm_dt = w_presion + w_humedad + w_Taire + w_Tdrop
	else:
		var diff_temp = t_drop - T_ref
		var k_temp_easy = 0.01
		dm_dt = -k_temp_easy * diff_temp

	return dm_dt * K


# func _on_death_floor_fall() -> void:
#	reset()

#func reset():
#	get_tree().reload_current_scene()
	
func pause():
	$PauseMenu.show()
	get_tree().paused = true
