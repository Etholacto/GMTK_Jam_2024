extends CanvasLayer
 
@onready var panel_container = $%PanelContainer

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
	if defeat_type == "too_small":
		$%TitleLabel.text = "Defeat"
		$%DescriptionLabel.text = "You were too Small"
	if defeat_type == "too_big":
		$%TitleLabel.text = "Defeat"
		$%DescriptionLabel.text = "You got too Big"
	
	$%RestartButton.visible = true
	$%NextLevelButton.visible = false
	play_jingle(true)
	
	
func play_jingle(defeat: bool =false):
	if defeat:
		$DefeatStreamPlayer.play()
	else:
		$VictoryStreamPlayer.play()
	
	
func on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	
func on_next_level_pressed():
	get_tree().paused = false
	#get_tree().change_scene_to_file()	
	
func on_quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
