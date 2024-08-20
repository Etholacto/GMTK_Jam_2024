extends CharacterBody2D

const SPEED := 130
const ACCELERATION := 800
const FRICTION := 1000
const GRAVITY := 1000
const FALL_GRAVITY := 1500

@onready var health_component = $HealthComponent
@onready var size_change_component = $SizeChangeComponent
@onready var hit_interval_timer = $HitIntervalTimer
@onready var visuals = $Visuals
@onready var start_scale: Vector2 = -visuals.scale
@onready var grow_audio_player = $GrowAudioPlayer
@onready var shrink_audio_player = $ShrinkAudioPlayer
@onready var animation_player = $AnimationPlayer

var jump_height := -400
var jump_speed := 130
var should_change_size: bool = true

func _ready():
	GameEvents.hit_enemy_of_type.connect(on_enemy_hit)
	hit_interval_timer.timeout.connect(on_timer_timeout)
	
	size_change_component.change_size()

func _process(delta):
	player_movement(delta)
	if global_position.y > 1000:
		health_component.damage(100, true)
		
	if velocity.x != 0 and velocity.y == 0:
		animation_player.play("walk")
	elif !is_on_floor():
		$Visuals/Sprite2D.texture = load("res://scenes/game_objects/player/player_action.png")
	else:
		animation_player.stop()


func player_movement(delta):
	if not is_on_floor():
		velocity.y += get_gravity(velocity) * delta
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = jump_height/4
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_height
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction and !is_on_floor():
		velocity.x = move_toward(velocity.x, direction * jump_speed, ACCELERATION * delta)
	elif direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		pass
	move_and_slide()
	
	if not is_zero_approx(velocity.x):
		visuals.scale.x = sign(velocity.x) * start_scale.x


func get_gravity(velocity: Vector2):
	if velocity.y < 0:
		return GRAVITY
	return FALL_GRAVITY
	

func change_jump_to_size(type: String):
	if type == "grow":
		if jump_height == -400:
			jump_speed += 50
		if jump_height < -400:
			jump_height += 100
	if type == "shrink":
		if jump_speed == 130:
			jump_height -= 100
		if  jump_speed > 130:
			jump_speed -= 50
	
	
func on_health_changed():
	GameEvents.emit_player_damaged()
	
func on_enemy_hit(enemy_health: HealthComponent, enemy_type: String):
	if enemy_health == null:
		return
		
	if enemy_health.current_health <= health_component.current_health and should_change_size:
		if enemy_type == "growth_type_enemy":
			health_component.healing(1)
			grow_audio_player.play()
			change_jump_to_size("grow")
		if enemy_type == "shrink_type_enemy":
			health_component.damage(1)
			shrink_audio_player.play()
			change_jump_to_size("shrink")
		size_change_component.change_size()
		enemy_health.damage(100)
		hit_interval_timer.start()
	
	if enemy_health.current_health > health_component.current_health:
		health_component.damage(100)


func on_timer_timeout():
	should_change_size = true
