extends Button


func _ready():
	pressed.connect(on_pressed)
	
	
func on_pressed():
	$AudioStreamPlayer.play()
