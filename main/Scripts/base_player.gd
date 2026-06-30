@abstract class_name BasePlayer
extends CharacterBody2D
## The base movement, physics, and visuals for every character
##
## The [annotation BasePlayer.class] is used for all essential methodes.[br]
## This inclueds all essential variables and [code]@abstract[/code] methodes.
##



##The base movemnet in [b]px/s[/b] of the player
var _base_movement_speed: float :
	get: return _base_movement_speed
	set(value): if(value >= 0): _base_movement_speed = value
var _base_sprint_mult_percent: float :
	get: return _base_sprint_mult_percent
	set(value): 
		if(value >= -10000 && value <= 10000):
			_base_sprint_mult_percent = value
var _base_max_stamina: float :
	get: return _base_max_stamina
	set(value): 
		if (value < _current_stamina):
			_current_stamina = value
		_base_max_stamina = value
var _base_max_health: float :
	get: return _base_max_health
	set(value):
		if(value < _current_health):
			_current_health = value
		_current_max_health = value
var _base_regain_percent: float:
	get: return _base_regain_percent
	set(value):
		if (value >= -10000 && value <= 10000):
			_base_regain_percent = value
var _current_stamina: float :
	get: return _current_stamina
	set(value):
		if(value >= 0):
			_current_stamina = value
		else:
			_current_stamina = 0
var _current_max_health: float :
	get: return _current_max_health
	set(value):
		if(value < _current_health):
			set(&"_current_health",value)
		_current_max_health = value
var _current_health: float :
	get: return _current_health
	set(value): if (value >= 0): _current_health = value

# Visuals


var _tint: Color :
	get: return _tint
	set(value): _tint = value
var _texture: Texture2D:
	get: return _texture
	set(value): _texture = value
var _animation_size: Vector2i:
	get: return _animation_size
	set(value): _animation_size = value
var _sprite: Sprite2D:
	get: return _sprite
var _animation_timer: float = 0 :
	get: return _animation_timer
	set(value): _animation_timer = fmod(abs(value),_animation_size.x * _animation_size.y)
var _last_direction: Vector2 = Vector2.DOWN :
	get: return _last_direction.normalized()
	set(value): _last_direction = value.normalized()

# Control

##Player's inventory of items, based on item id.
var _item_ids : Dictionary[int,PlayerItemResource] = {}

func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown", 0.15)

	if (input_direction.length() > 0.15):
		_last_direction = input_direction.normalized()
		velocity = input_direction * _base_movement_speed
	else:
		velocity = Vector2.ZERO

	if (
	Input.is_action_pressed("Sprint") 
	&& _current_stamina != 0 
	&& velocity.length_squared() >= 0.1
	):
		velocity *= _base_sprint_mult_percent
		_current_stamina -= delta
	elif (!Input.is_action_pressed("Sprint") || velocity.length_squared() < 0.1):
		_current_stamina += delta * (_base_regain_percent/100.0)
		if (velocity.length_squared() < 0.1 && !Input.is_action_pressed("Sprint")):
			var faster_gain = delta
			faster_gain *= _base_max_stamina - _current_stamina
			faster_gain *= (_base_regain_percent/100.0)
			_current_stamina += faster_gain
	_current_stamina = clampf(_current_stamina, 0, _base_max_stamina)
	
	move_and_slide()

##Updates the player's sprite
func update_sprite(vel: float = 0.0) -> void:
	var snapped_angle_index: int = roundi(_last_direction.angle() * (4 / PI))
	if (snapped_angle_index < 0):
		snapped_angle_index += 8

	_sprite.modulate = _tint

	_animation_timer += get_process_delta_time() * 8
	_animation_timer = fmod(_animation_timer, 8.0)

	if (vel > 0.15 and Input.is_action_pressed("Sprint") and _current_stamina > 0):
		_sprite.frame_coords = Vector2i(16 + floori(_animation_timer), snapped_angle_index)
	elif (vel > 0.15 and (not Input.is_action_pressed("Sprint") or _current_stamina <= 0)):
		_sprite.frame_coords = Vector2i(8 + floori(_animation_timer), snapped_angle_index)
	else:
		_sprite.frame_coords = Vector2i(floori(_animation_timer), snapped_angle_index)

##Fires all items, in the player's inventory, of type weapon.
func fire_weapons(delta: float) -> void:
	for weapon in get_children():
		if (weapon is WeaponMarker):
			if (weapon.id in _item_ids):
				weapon.delta_timer += delta
				if (weapon.delta_timer > weapon.cooldown):
					weapon.delta_timer = 0
					weapon.shoot()

##Adds an item to the player's inventory.[br][br]
##[b]Note:[/b] Go to [u]res://main/Recources/Items/...[/u] to read, write, delete and create items
func add_item(item_id: int) -> void:
	var dir := DirAccess.open("res://main/Recources/Items/")
	
	for file in dir.get_files():
		if (file.get_extension() == "tres"):
			var read_file := load("res://main/Recources/Items/%s.tres" % file.get_basename())
			var meta_file = read_file.get_meta(&"data",null)
			if (meta_file):
				print(item_id)
			else:
				print_rich(
				"""[color=red]Metadata [i]data[/i] 
				does not exits in file[/color] 
				[i]res://main/Recources/Items/%s.tres[/i]""" % file.get_basename())
		else:
			pass
