extends CanvasLayer

var level_select_scene = preload("res://scenes/ui/level_select.tscn")
var options_scene = preload("res://scenes/ui/options_menu.tscn")

func _ready():
	$%PlayButton.pressed.connect(on_play_pressed)
	$%LevelSelectButton.pressed.connect(on_level_select_pressed)
	$%OptionsButton.pressed.connect(on_options_pressed)
	$%QuitButton.pressed.connect(on_quit_pressed)
	
	
func on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level1/main.tscn")


func on_level_select_pressed():
	var level_select_instance = level_select_scene.instantiate()
	add_child(level_select_instance)
	level_select_instance.back_pressed.connect(on_level_select_closed.bind(level_select_instance))
	

func on_options_pressed():
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))


func on_quit_pressed():
	get_tree().quit()

func on_level_select_closed(level_select_instance: Node):
	level_select_instance.queue_free()

func on_options_closed(options_instance: Node):
	options_instance.queue_free()
