extends Node

@export var health_component: HealthComponent
@export var body: CharacterBody2D

var current_health: int
	

func change_size():
	current_health = health_component.current_health
	if 0 < current_health and current_health <= 5:
		var decrease = 0.2 * current_health
		body.scale = Vector2(decrease, decrease)
	elif 5 < current_health and current_health <= 9:
		var increase = pow(2, (current_health - 5))
		body.scale = Vector2(increase, increase)
