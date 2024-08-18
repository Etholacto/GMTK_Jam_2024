extends CanvasLayer


@onready var label = $%Label

var time_elapsed := 0.0

func _process(delta):
	time_elapsed += delta
	label.text = str(format_seconds_to_string(time_elapsed))


func format_seconds_to_string(seconds: float):
	var minutes = floor(seconds/60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))
	
	
func get_elapsed_time():
	return time_elapsed
