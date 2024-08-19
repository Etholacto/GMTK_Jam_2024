extends CharacterBody2D

@onready var health_component = $HealthComponent

@export var health: float = 5
@export var direction: bool = false

func _ready():
	$HurtboxComponent.hit.connect(on_hit)
	$AnimationTimer.timeout.connect(on_timer_timeout)
	set_health(health)
	set_direction(direction)
	$AnimationTimer.start(randf_range(0.1, 1))


func set_health(health: float):
	health_component.current_health = health
	$SizeChangeComponent.change_size()


func set_direction(direction: bool):
	$Sprite2D.flip_h = direction


func on_hit():
	GameEvents.emit_hit_enemy_of_type(health_component, "growth_type_enemy")
	
func on_timer_timeout():
	$AnimationPlayer.play("float")
