extends PathFollow2D

@export var enemy_path: Path2D

var speed = 0.2
var target = 0.99
var enemy_instance: Node2D

func _ready():
	var enemy = enemy_path.get_enemy_scene()
	enemy_instance = enemy.instantiate() as Node2D
	add_child(enemy_instance)
	enemy_instance.set_health(enemy_path.get_enemy_health())

func _process(delta):
	var direction = bouncing_movement(delta)
	if enemy_instance != null:
		enemy_instance.set_direction(direction)

func bouncing_movement(delta):
	if progress_ratio < target:
		progress_ratio += delta * speed
		target = 0.99
		return false
	if progress_ratio > target:
		progress_ratio -= delta * speed
		target = 0.01
		return true
