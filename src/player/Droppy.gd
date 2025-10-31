extends RigidBody2D
class_name Droppy

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_cast_floot: RayCast2D = $RayCastFloot
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_manager: Node2D = $"../AudioManager"

var speed: float = 250 
var jump_impulse: float = 700 
var mass_scale_min: float = 1
var mass_scale_max: float = 3.5
var mass_min: float = 0.8
var mass_max: float = 1.2
var mass_scale_divisor: float = 0.9
var temperature: float = 20


func _physics_process(delta: float) -> void:
	#print("Raycast colisiona:", ray_cast_floot.is_colliding())
	#print(mass)
	#print({"temperaturaGota": temperature})
	animated_sprite_2d.global_rotation = 0
	ray_cast_floot.global_rotation = 0
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
	if Input.is_action_just_pressed("up") and ray_cast_floot.is_colliding():
		apply_impulse(Vector2(0, -jump_impulse))
		audio_manager.get_node("jump_sound_normal").play()
		
	
	#escala el sprite y el collisionShape dependiendo la cantidad de masa
	#el remap esta para que se exagere un poco mas el tamaño de la imagen en realacion con los valores de la masa
	var scale_factor = remap(mass, mass_min, mass_max, mass_scale_min, mass_scale_max)
	#print(scale_factor)
	var scale = Vector2.ONE * scale_factor
	animated_sprite_2d.scale = scale 
	collision_shape_2d.scale = scale
	ray_cast_floot.scale = scale

# actualiza masa con la variacion calculada por el nivel
func update_mass(variacion: float) -> void:
	mass = clamp(mass + variacion, mass_min, mass_max)

	
func update_temperature(temp: float) -> void:
	temperature += temp
	
