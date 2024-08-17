extends Button


func _ready():
	pressed.connect(on_pressed)
	
	
func on_pressed():
	pass
	#$RandomStreamPlayerComponent.play_random()
