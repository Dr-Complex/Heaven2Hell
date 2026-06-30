class_name BaseEnemy
extends Area2D

@export_group("Stats")
@export_range(0,1,0.05,"hide_control","or_greater","suffix:px/s") var base_speed: float = 100
@export_range(0,1,0.5,"hide_control","or_greater","suffix:dps") var base_damage: float = 7.5
@export_range(1,100,0.5,"hide_control","or_greater") var max_health: float = 25

@export_group("Animation")
@export_color_no_alpha var tint: Color
@export var atlas: Texture2D
@export var atlas_size: Vector2i = Vector2i(1, 1)
@export_range(0.001,1,0.001,"or_greater","hide_control","suffix:s") var animation_speed: float = 1
var _animation_timer: float
var _sprite: Node2D
