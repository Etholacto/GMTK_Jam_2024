extends Node
class_name HealthComponent

signal died
signal health_changed

@export var max_health: float = 5

var current_health

func _ready():
	current_health = max_health

func damage(hitpoints: float):
	current_health = max(current_health - hitpoints, 0)
	Callable(check_death).call_deferred()
	health_changed.emit()
	
func healing(healthpoints: float):
	current_health += healthpoints
	Callable(check_death).call_deferred()
	health_changed.emit()

func check_death():
	if current_health == 0 or current_health == 10:
		died.emit()
		owner.queue_free()
