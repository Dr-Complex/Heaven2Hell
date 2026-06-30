class_name EnemyHolder
extends Node2D

@export_range(0.0, 2 ** 10) var spawn_radius: float = 64

var player_target: BasePlayer
var spawn_center: Vector2 = Vector2.ZERO
var active_enemies: Array[BaseEnemy] = []

func Spawn(amount : int, types : Array[int]):
	pass
