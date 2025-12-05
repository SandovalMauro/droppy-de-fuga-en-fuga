class_name Level_selector
extends Node

var levels := [
	"res://src/world/levels/Level1.tscn",
	"res://src/world/levels/Level2.tscn",
	"res://src/world/levels/Level3.tscn"
]

var final_scene = "res://src/scenes/final.tscn"


var current_level_index := 0
var current_level_node: Node = null

func _ready():
	load_level(current_level_index)

func load_level(index: int):
	var level_path = levels[index]
	var level_scene = load(level_path)
	var level_instance = level_scene.instantiate()
	add_child(level_instance)
	

	var llegada = level_instance.get_node("Llegada")
	var victoria = llegada.get_node("Victoria")

	# Estado inicial: Victoria oculta
	victoria.visible = false
	victoria.set_process(false)
	victoria.get_child(0).visible = false

	victoria.next_level_pressed.connect(go_next_level)

	if llegada.has_meta("victoria"):
		llegada.victoria = victoria

func go_next_level():
	current_level_index += 1

	if current_level_index >= levels.size():
		show_final_screen()
		return

	get_child(0).queue_free()
	load_level(current_level_index)
	
func show_final_screen():
	# Limpiar el nivel actual si existe
	if get_child_count() > 0:
		get_child(0).queue_free()

	var final = load(final_scene)
	var final_instance = final.instantiate()
	add_child(final_instance)
	
