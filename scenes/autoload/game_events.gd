extends Node

signal player_damaged
signal hit_enemy_of_type(enemy_health: HealthComponent, enemy_type: String)


func emit_player_damaged():
	player_damaged.emit()


func emit_hit_enemy_of_type(enemy_health: HealthComponent, enemy_type: String):
	hit_enemy_of_type.emit(enemy_health, enemy_type)
