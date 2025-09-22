extends Node

# temperature_air: temperatura ambiente (°C)
# humidity: humedad relativa (0.0 - 1.0)
# pressure_atm:: presión ambiente (atm)
@export var temperature_air: float #= 0
@export var humidity: float #= 0
@export var pressure_atm: float #= 0

const K := 0.00005 #0.001 # coeficiente ajustable para el juego

@onready var droppy: Droppy = $Droppy

func _ready() -> void:
	#var T_drop = 25.0   # °C
	#var T_air = 30.0    # °C
	#var RH = 0.5        # 50%
	#var P_atm = 1.0     # atm
	##var m = 2.0        # masa arbitraria
	#var m = droppy.mass
	temperature_air = 30
	humidity = 0.5
	pressure_atm = 1

func _physics_process(delta: float) -> void:
	droppy.update_mass(calcular_estado(droppy.temperature, temperature_air, humidity, pressure_atm, droppy.mass))


# Presión de saturación (kPa) con Magnus-Tetens
func p_sat(T: float) -> float:
	return 0.611 * exp((17.27 * T) / (T + 237.3))

# Calcula el estado de la gota
# t_drop: temperatura de la gota (°C)
# m: masa de la gota
# t_air: temperatura ambiente (°C)
# hum: humedad relativa (0.0 - 1.0)
# p_atm: presión ambiente (atm)
func calcular_estado(t_drop: float, t_air: float, hum: float, p_atm: float, m: float, k: float = K) -> float:
	var p_drop = p_sat(t_drop)     # presión de vapor en la gota
	var p_air = hum * p_sat(t_air)  # presión de vapor en el aire
	
	var delta_p = p_drop - p_air
	var estado = ""
	var velocidad = 0.0
	
	if abs(delta_p) < 0.001:
		estado = "equilibrio"
		velocidad = 0.0
	elif delta_p > 0:
		estado = "evaporando"
		velocidad = -k * delta_p * pow(m, 2.0/3.0) / p_atm
	else:
		estado = "condensando"
		velocidad = k * abs(delta_p) * pow(m, 2.0/3.0) / p_atm
	
	print({
		"estado": estado,
		"dm_dt": velocidad, # cambio de masa por segundo
		"m": m + velocidad, # masa actualizada (si querés aplicarlo)
		"delta_p": delta_p
	})
	return velocidad
	
