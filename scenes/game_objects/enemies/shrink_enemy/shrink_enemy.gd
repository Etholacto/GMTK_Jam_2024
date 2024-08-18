extends CharacterBody2D

@onready var health_component = $HealthComponent
@onready var size_change_component = $SizeChangeComponent
@onready var sprite_2d = $Sprite2D

@export var health: float = 5
@export var direction: bool = false

func _ready():
	$HurtboxComponent.hit.connect(on_hit)
	set_health(health)
	set_direction(direction)
	
	
func set_health(health: float):
	health_component.current_health = health
	size_change_component.change_size()


func set_direction(direction: bool):
	sprite_2d.flip_h = direction
	

func on_hit():
	GameEvents.emit_hit_enemy_of_type($HealthComponent, "shrink_type_enemy")
