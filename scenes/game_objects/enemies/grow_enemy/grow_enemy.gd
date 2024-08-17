extends CharacterBody2D

@onready var health_component = $HealthComponent
@onready var size_change_component = $SizeChangeComponent

@export var health: float = 5

func _ready():
	$HurtboxComponent.hit.connect(on_hit)
	set_health(health)


func set_health(health: float):
	health_component.current_health = health
	size_change_component.change_size()


func on_hit():
	GameEvents.emit_hit_enemy_of_type($HealthComponent, "growth_type_enemy")
