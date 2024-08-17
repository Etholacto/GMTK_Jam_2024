extends Node
class_name HealthComponent

signal died(defeat_type: String)

@export var max_health: float = 5

var current_health
var enemy_type

func _ready():
	current_health = max_health

func damage(hitpoints: float):
	current_health = max(current_health - hitpoints, 0)
	Callable(check_death).call_deferred()
	
func healing(healthpoints: float):
	current_health += healthpoints
	Callable(check_death).call_deferred()
	

func check_death():
	if current_health == 0:
		died.emit("too_small")
		owner.queue_free()
	if current_health == 10:
		died.emit("too_big")
		owner.queue_free()
	

