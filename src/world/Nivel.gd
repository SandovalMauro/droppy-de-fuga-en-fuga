extends Node
#hacerla abstracta

# temperature_air: temperatura ambiente (°C)
# humidity: humedad relativa (0.0 - 1.0)
# pressure_atm:: presión ambiente (atm)
@export var temperature_air: float #= 0
@export var humidity: float #= 0
@export var pressure_atm: float #= 0

const K := 0.0005  # coeficiente general para ajustar el juego

@onready var droppy: Droppy = $Droppy

func _ready() -> void:
	temperature_air = 22#30
	humidity = 0.5#0.5
	pressure_atm = 0.5 #1

func _physics_process(delta: float) -> void:
	droppy.update_mass(calcular_estado(droppy.temperature, temperature_air, humidity, pressure_atm, droppy.mass))


func calcular_estado(t_drop: float, t_air: float, hum: float, p_atm: float, m: float) -> float:
	# Referencias que definen el equilibrio
	var T_ref = 20.0   # °C
	var RH_ref = 0.5   # 50%
	var P_ref = 1.0    # atm

	# Ajustar para calibrar el peso de cada variable
	var k_presion = 0.005
	var k_humedad = 0.003
	var k_Taire = 0.00005
	var k_Tdrop = 0.00005

	# Calculo, resto el valor de equilibrio a los pasados por parametro y multiplico por el peso
	var w_presion = k_presion * (p_atm - P_ref)
	var w_humedad = k_humedad * (hum - RH_ref)
	var w_Taire = -k_Taire * (t_air - T_ref)
	var w_Tdrop = -k_Tdrop * (t_drop - T_ref)

	# Calculo el cambio masa
	var dm_dt = w_presion + w_humedad + w_Taire + w_Tdrop
	print({"presion:": w_presion, "humedad:":w_humedad, "temp aire:":w_Taire, "temp gota:": w_Tdrop})
	print({"dm" : dm_dt, "dm-K" : dm_dt * K})
	return dm_dt * K
