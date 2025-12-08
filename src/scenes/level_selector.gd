class_name Level_selector
extends Node

var levels := [
	"res://src/world/levels/Level1.tscn",
	"res://src/world/levels/Level2.tscn",
	"res://src/world/levels/Level3.tscn",
	"res://src/world/levels/Level4.tscn"
]

var final_scene = "res://src/scenes/final.tscn"

var current_level_index := 0
var current_level_node: Node = null

func _ready():
	load_level(current_level_index)

func load_level(index: int):
	for c in get_children():
		c.queue_free()
	
	var level_path = levels[index]
	var level_scene = load(level_path)
	var level_instance = level_scene.instantiate()
	add_child(level_instance)
	
	var llegada = level_instance.get_node("Llegada")
	var victoria = llegada.get_node("Victoria")
	
	victoria.visible = false
	victoria.set_process(false)
	victoria.get_child(0).visible = false
	
	llegada.finished_level.connect(
		Callable(self, "decide_finished_or_next_level").bind(victoria)
	)
	
	var death_floor = level_instance.get_node("DeathFloor")
	death_floor.fall.connect(reset_level)
	
	if llegada.has_meta("victoria"):
		llegada.victoria = victoria

func decide_finished_or_next_level(victoria: Control):
	if current_level_index >= levels.size()-1:
		show_final_screen()
		return
	else:
		victoria.visible = true
		victoria.set_process(true)
		victoria.get_child(0).visible = true
		victoria.next_level_pressed.connect(go_next_level)

func reset_level():
	load_level(current_level_index)

func go_next_level():
	current_level_index += 1
	get_child(0).queue_free()
	load_level(current_level_index)

func show_final_screen():
	# Limpiar el nivel actual si existe
	if get_child_count() > 0:
		get_child(0).queue_free()
	
	var final = load(final_scene)
	var final_instance = final.instantiate()
	add_child(final_instance)
	
