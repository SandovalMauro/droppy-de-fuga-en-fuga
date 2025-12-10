extends AnimatableBody2D


@export var velocidad_giro: float = 2.0

func _physics_process(delta: float) -> void:
	rotation += velocidad_giro * delta
