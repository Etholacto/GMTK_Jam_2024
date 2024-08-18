extends Camera2D

var target_position = Vector2.ZERO
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()
	zoom = Vector2(1,1)
	GameEvents.hit_enemy_of_type.connect(zoom_camera_on_size_change)
	
	player = get_tree().get_first_node_in_group("player") as Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	aquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 50))


func aquire_target():
	if player == null:
		return
		
	target_position.x = player.global_position.x
	target_position.y = player.global_position.y - 75
	

func zoom_camera_on_size_change(_enemy_health: HealthComponent, enemy_type: String):
	if player == null:
		return
	
	if enemy_type == "growth_type_enemy" and !zoom.is_equal_approx(Vector2(0.2, 0.2)) and !(player.scale < Vector2(1, 1)):
		zoom += Vector2(-0.2, -0.2)
	if enemy_type == "shrink_type_enemy" and !zoom.is_equal_approx(Vector2(1, 1)):
		zoom += Vector2(0.2, 0.2)
	print(str(zoom))
