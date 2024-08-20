extends CanvasLayer

signal back_pressed

@onready var back_button = $%BackButton
@onready var level_1_button = %Level1Button
@onready var level_2_button = %Level2Button
@onready var level_3_button = %Level3Button
@onready var level_4_button = %Level4Button

func _ready():
	back_button.pressed.connect(on_back_pressed)
	level_1_button.pressed.connect(on_level_1_pressed)
	level_2_button.pressed.connect(on_level_2_pressed)
	level_3_button.pressed.connect(on_level_3_pressed)
	level_4_button.pressed.connect(on_level_4_pressed)


func on_back_pressed():
	back_pressed.emit()
	
	
func on_level_1_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level1/main.tscn")
	
	
func on_level_2_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level2/lvl2.tscn")
	
	
func on_level_3_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level3/lvl3.tscn")
	

func on_level_4_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level4/lvl4.tscn")
