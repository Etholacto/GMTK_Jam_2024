extends CanvasLayer
 
@onready var panel_container = $%PanelContainer

var next_level: PackedScene
var elapsed_time := 0.0

func _ready():
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	get_tree().paused = true
	$%RestartButton.pressed.connect(on_restart_button_pressed)
	$%NextLevelButton.pressed.connect(on_next_level_pressed)
	$%QuitButton.pressed.connect(on_quit_button_pressed)
	
	
func set_defeat(defeat_type: String):
	$%TitleLabel.text = "Defeat"
	if defeat_type == "too_small":
		$%DescriptionLabel.text = "You were too Small"
	if defeat_type == "too_big":
		$%DescriptionLabel.text = "You got too Big"
	if defeat_type == "fall":
		$%DescriptionLabel.text = "You fell through the Abyss"
	
	$%RestartButton.visible = true
	$%NextLevelButton.visible = false
	play_jingle(true)
	
	
func play_jingle(defeat: bool =false):
	if defeat:
		$DefeatStreamPlayer.play()
	else:
		$VictoryStreamPlayer.play()
	

func set_next_level(next_level_scene: PackedScene):
	next_level = next_level_scene
	
	
func set_elapsed_time(time: float):
	var minutes := time / 60
	var seconds := fmod(time, 60)

	var milliseconds := fmod(time, 1) * 100

	var elapsed_time = "Time: %02d:%02d:%02d" % [minutes, seconds, milliseconds]
	$%DescriptionLabel.text = elapsed_time
	
	
func on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	
func on_next_level_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(next_level.resource_path)	
	
	
func on_quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
