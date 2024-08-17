extends PathFollow2D

@export var enemy_path: Path2D

var speed = 0.2
var target = 0.99

func _ready():
	var enemy = enemy_path.get_enemy_scene()
	var enemy_instance = enemy.instantiate() as Node2D
	add_child(enemy_instance)
	enemy_instance.set_health(enemy_path.get_enemy_health())

func _process(delta):
	bouncing_movement(delta)

func bouncing_movement(delta):
	if progress_ratio < target:
		progress_ratio += delta * speed
		target = 0.99
	if progress_ratio > target:
		progress_ratio -= delta * speed
		target = 0.01
