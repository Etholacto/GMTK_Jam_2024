extends PathFollow2D

@export var enemy_path: Path2D

@onready var timer = $"../Timer"

var speed = 0.2
var target = 0.99
var enemy_instance: Node2D
var follow: bool = false
var direction: bool = false

func _ready():
	timer.timeout.connect(on_timer_timeout)
	var enemy = enemy_path.get_enemy_scene()
	enemy_instance = enemy.instantiate() as Node2D
	add_child(enemy_instance)
	enemy_instance.set_health(enemy_path.get_enemy_health())
	timer.start(randf_range(0.1, 2))

func _process(delta):
	if follow:
		direction = bouncing_movement(delta)
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


func on_timer_timeout():
	follow = true
