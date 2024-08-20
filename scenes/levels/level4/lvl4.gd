extends Node

@export var end_screen_scene: PackedScene
@export var victory_area: VictoryArea
@export var timer: CanvasLayer

var pause_menu_scene = preload("res://scenes/ui/pause_menu.tscn")
var level_4_scene = preload("res://scenes/ui/end_screen.tscn")


func _ready():
	$%Player.health_component.died.connect(on_player_died)
	$VictoryArea.area_entered.connect(on_area_entered)
	

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		add_child(pause_menu_scene.instantiate())
		get_tree().root.set_input_as_handled()
		
func on_player_died(defeat_type: String):
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat(defeat_type)


func on_area_entered(other_area: Area2D):
	if not other_area is HitboxComponent:
		return
	
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_next_level(level_4_scene)
	
	var time = timer.get_elapsed_time()
	end_screen_instance.set_elapsed_time(time)
