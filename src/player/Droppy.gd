extends RigidBody2D
class_name Droppy

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var stabilizer: Node2D = $Stabilizer
@onready var ray_cast_floot_c: RayCast2D = $Stabilizer/RayCastFlootC
@onready var ray_cast_floot_der: RayCast2D = $Stabilizer/RayCastFlootD
@onready var ray_cast_floot_cder: RayCast2D = $Stabilizer/RayCastFlootCD
@onready var ray_cast_floot_izq: RayCast2D = $Stabilizer/RayCastFlootI
@onready var ray_cast_floot_cizq: RayCast2D = $Stabilizer/RayCastFlootCI


@onready var animated_sprite_2d: AnimatedSprite2D = $Stabilizer/AnimatedSprite2D
@onready var audio_manager: Node2D = $"../AudioManager"
@onready var camera: Camera2D = $Camera2D

@export var speed: float = 250
@export var jump_impulse: float = 700 
var mass_scale_min: float = 1
var mass_scale_max: float = 3.5
var mass_min: float = 0.8
var mass_max: float = 1.2
var mass_scale_divisor: float = 0.9
var temperature: float = 20

var puede_moverse: bool = true

func _physics_process(delta: float) -> void:
	stabilizer.global_rotation = 0
	#animated_sprite_2d.global_rotation = 0
	#ray_cast_floot.global_rotation = 0
	#ray_cast_floot_der.global_rotation = -60
	#ray_cast_floot_izq.global_rotation = 60
	
	if not puede_moverse:
		return
	
	#Movimiento horizontal
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("right"):
		input_vector.x += 1
	if Input.is_action_pressed("left"):
		input_vector.x -= 1

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized() * speed
		apply_central_force(input_vector)
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("idle")
		
	#Salto
	if Input.is_action_just_pressed("up") and is_on_floor_custom():
		apply_impulse(Vector2(0, -jump_impulse))
		if mass <= 0.96:
			audio_manager.get_node("jump_sound_small").play()
		elif mass >= 1.05:
			audio_manager.get_node("jump_sound_big").play()
		else:
			audio_manager.get_node("jump_sound_normal").play()
	
	#escala el sprite y el collisionShape dependiendo la cantidad de masa
	#el remap esta para que se exagere un poco mas el tamaño de la imagen en realacion con los valores de la masa
	var scale_factor = remap(mass, mass_min, mass_max, mass_scale_min, mass_scale_max)
	#print(scale_factor)
	var scale = Vector2.ONE * scale_factor
	animated_sprite_2d.scale = scale 
	collision_shape_2d.scale = scale
	ray_cast_floot_c.scale = scale
	ray_cast_floot_der.scale = scale
	ray_cast_floot_cder.scale = scale
	ray_cast_floot_izq.scale = scale
	ray_cast_floot_cizq.scale = scale

# actualiza masa con la variacion calculada por el nivel
func update_mass(variacion: float) -> void:
	mass = clamp(mass + variacion, mass_min, mass_max)
	
func update_temperature(temp: float) -> void:
	temperature += temp
	
func limit_camera(limite : float):
	camera.limit_right = limite
	
func is_on_floor_custom() -> bool:
	return ray_cast_floot_c.is_colliding() or ray_cast_floot_der.is_colliding() or ray_cast_floot_izq.is_colliding() or ray_cast_floot_cder.is_colliding() or ray_cast_floot_cizq.is_colliding()

func desactivar_movimiento():
	puede_moverse = false
