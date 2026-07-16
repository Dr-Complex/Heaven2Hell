#@icon("")
class_name BackDrop
extends TileMapLayer

@export var root: MainManager
@export var node_player: BasePlayer
@export var node_camera: Camera2D

var update_timer:float = 0
var sides_length: Vector2 = Vector2.ZERO

func _ready() -> void:
	scale = Vector2(2,2)

func tiles_tick(delta: float) -> void:
	if (node_player and node_camera):
		sides_length.x = node_camera.get_viewport_rect().size.x / 50.0
		sides_length.y = node_camera.get_viewport_rect().size.y / 10.0
		sides_length /= 2.0
		
		node_camera.position += ((node_player.position - node_camera.position) * 
			delta * (node_player.current_movement_speed / 100))
		
		if (update_timer <= 0):
			clear()
			update_timer = 0.1
			area_loop()
		else:
			update_timer -= delta

func area_loop() -> void:
	var center : Vector2i = Vector2i(
		roundi(node_camera.position.x / 64.0),
		roundi(node_camera.position.y / 16.0))

	for iy in range(-sides_length.y, sides_length.y, 1):
		for ix in range(-sides_length.x, sides_length.x, 1):
			set_cell_random(center + Vector2i(ix,iy))

func set_cell_random(pos : Vector2i) -> void:
	var random_index: int = int(root.random_noise.get_noise_2dv(pos) * 13.0 * 1.5)
	random_index %= 13
	if (random_index <= 0):
		random_index *= -1
	var tiles_indes: Array[Vector2i] = [
		Vector2i(0,0),
		Vector2i(1,0),
		Vector2i(2,0),
		Vector2i(3,0),
		Vector2i(4,0),
		Vector2i(0,1),
		Vector2i(1,1),
		Vector2i(2,1),
		Vector2i(3,1),
		Vector2i(4,1),
		Vector2i(0,2),
		Vector2i(1,2),
		Vector2i(2,2),]
	set_cell(pos,0,tiles_indes[random_index])
