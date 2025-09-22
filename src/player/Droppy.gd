extends RigidBody2D
class_name Droppy

@onready var sprite = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var speed: float = 400 
var jump_impulse: float = 700  # impulso de salto
var mass_scale_min: float = 1
var mass_scale_max: float = 3.5
var mass_min: float = 0.8
var mass_max: float = 1.2
var mass_scale_divisor: float = 0.9
var temperature: float = 25

func _physics_process(delta: float) -> void:
	# --- Movimiento horizontal ---
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("right"):
		input_vector.x += 1
	if Input.is_action_pressed("left"):
		input_vector.x -= 1

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized() * speed
		apply_central_force(input_vector)
		
	# --- Salto ---
	if Input.is_action_just_pressed("up"):
		apply_impulse(Vector2(0, -jump_impulse))
		
	var scale_factor = remap(mass, mass_min, mass_max, mass_scale_min, mass_scale_max) #clamp(mass / mass_scale_divisor, mass_scale_min, mass_scale_max)
	print(scale_factor)
	sprite.scale = Vector2.ONE * scale_factor
	collision_shape_2d.scale = sprite.scale


func update_mass(variacion: float) -> void:
	mass = clamp(mass + variacion, mass_min, mass_max)
