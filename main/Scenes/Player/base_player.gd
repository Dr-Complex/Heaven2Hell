@abstract class_name BasePlayer
extends CharacterBody2D
## The base for every character
##
## This class inclueds all essential variables and methodes.
##

# Stats
@export_group("Stats","base_")

## Movement speed, in [b]px/s[/b], of the player
@export_range(0,1,0.1,"hide_control","or_greater","suffix:px/s")
var base_movement_speed: float :
	get: return base_movement_speed
	set(value): 
		if(value >= 0):
			if(value < _current_movement_speed):
				_current_movement_speed = value
			base_movement_speed = value
		else:
			_current_movement_speed = 0
			base_movement_speed = 0

## The percent of [param _base_movement_speed] added to itself when holding down [kbd]Ctrl[/kbd]
@export_range(-1000,1000,0.1,"hide_control","suffix:%")
var base_sprint_mult_percent: float :
	get: return base_sprint_mult_percent
	set(value): 
		if(abs(value) <= 1000):
			if (abs(value) <= _current_mult_percent):
				_current_mult_percent = value
			base_sprint_mult_percent = value
		else:
			_current_mult_percent = 1000 * sign(value)
			base_sprint_mult_percent = 1000 * sign(value)

## How long [kbd]Ctrl[/kbd] can be held down consequently 
@export_range(0,1,0.1,"hide_control","or_greater","suffix:s")
var base_max_stamina: float :
	get: return base_max_stamina
	set(value):
		if(value >= 0):
			if (value <= _current_max_stamina):
				_current_max_stamina = value
			base_max_stamina = value
		else:
			_current_max_stamina = 0
			base_max_stamina = 0

## Base and starting health of the character
@export_range(1,2,1,"hide_control","or_greater")
var base_max_health: float :
	get: return base_max_health
	set(value):
		if(value >= 1):
			if(value <= _current_max_health):
				_current_max_health = value
			base_max_health = value
		else:
			_current_max_health = 1
			base_max_health = 1

## Stamina recovery, in [b]%/s[/b]
@export_range(-1000,1000,0.1,"hide_control","suffix:%/s")
var base_stamina_recovery_percent: float:
	get: return base_stamina_recovery_percent
	set(value):
		if (abs(value) <= 1000):
			if(abs(value) <= _current_stamina_recovery_percent):
				_current_stamina_recovery_percent = value
			base_stamina_recovery_percent = value
		else:
			_current_stamina_recovery_percent = 1000 * sign(value)
			base_stamina_recovery_percent = 1000 * sign(value)

## Health recovery, in [b]1/s[/b]
@export_range(0,1,0.1,"hide_control","or_greater","suffix:/s")
var base_health_recovery: float:
	get: return base_health_recovery
	set(value):
		if (value >= 0):
			if(value <= _current_health_recovery):
				_current_health_recovery = value
			base_health_recovery = value
		else:
			_current_health_recovery = 0
			base_health_recovery = 0

## Damage reduction ([code]x > 0[/code]) or increaser ([code]x < 0[/code])
@export_range(0,1,0.1,"hide_control","or_less","or_greater","suffix:%")
var base_resistance: float:
	get: return base_resistance
	set(value): base_resistance = value

## Invincible in ms
@export_range(0,15000,0.1,"hide_control","suffix:ms")
var base_invincible: float:
	get: return base_invincible
	set(value):
		if(value>=0 and value <= 15000):
			if(value <= _current_invincible):
				_current_invincible = value
			base_invincible = value
		elif(value <= 0):
			_current_invincible = 0
			base_invincible = 0
		else:
			_current_invincible = 15000
			base_invincible = 15000

var _current_movement_speed: float:
	get: return _current_movement_speed
	set(value): 
		if(value >= 0):
			_current_movement_speed = value
		else:
			_current_movement_speed = 0
var _current_mult_percent: float:
	get: return _current_mult_percent
	set(value): 
		if(abs(value) <= 1000):
			_current_mult_percent = value
		else:
			_current_mult_percent = 1000 * sign(value)
var _current_max_stamina: float:
	get: return _current_max_stamina
	set(value):
		if (value >= 0):
			_current_max_stamina = value
		else:
			_current_max_stamina = 0
var _current_max_health: float:
	get: return _current_max_health
	set(value):
		if(value >= 1):
			_current_max_health = value
		else:
			_current_max_health = 1
var _current_stamina_recovery_percent: float:
	get: return _current_stamina_recovery_percent
	set(value):
		if (abs(value) <= 1000):
			_current_stamina_recovery_percent = value
		else:
			_current_stamina_recovery_percent = 1000 * sign(value)
var _current_health_recovery: float:
	get: return _current_health_recovery
	set(value):
		if (value >= 0):
			_current_health_recovery = value
		else:
			_current_health_recovery = 0
var _current_resistance: float:
	get: return _current_resistance
	set(value): _current_resistance = value
var _current_invincible: float:
	get: return _current_invincible
	set(value):
		if(value >= 0 and value <= 15000):
			_current_invincible = value
		elif(value <= 0):
			_current_invincible = 0
		else:
			_current_invincible = 15000
var _current_stamina: float:
	get: return _current_stamina
	set(value): 
		if (value <= _current_max_stamina and value >= 0):
			_current_stamina = value
		elif (value <= 0):
			_current_stamina = 0
		else:
			_current_stamina = _current_max_stamina
var _current_health: float:
	get: return _current_health
	set(value):
		if(value >= 0 and value <= _current_max_health):
			_current_health = value
		elif(value <= 0):
			_current_health = 0
		else :
			_current_health = _current_max_health
var _current_invincible_timer: float:
	get: return _current_invincible_timer
	set(value):
		if(value >= 0):
			_current_invincible_timer = value
		else:
			_current_invincible_timer = 0


# Visuals
@export_group("Visuals", "vis_")

## Color overlay over [param atles] that last 
@export_color_no_alpha
var vis_tint: Color:
	get: return vis_tint
	set(value): vis_tint = value

## The full atles of sprites for character
@export
var vis_atles: Texture2D:
	get: return vis_atles
	set(value): vis_atles = value

## Each cell of the animation [b]MUST BE[/b] square [b]AND[/b] the same size.
@export_range(1,2,1,"hide_control","or_greater","suffix:px")
var vis_square_cell_size: int:
	get: return vis_square_cell_size
	set(value):
		if(value >= 1):
			vis_square_cell_size = value
		else:
			vis_square_cell_size = 1

## How many frams in direction [param x] and [param y]
@export_custom(PROPERTY_HINT_NONE, "suffix:cells")
var vis_animation_size: int:
	get: return vis_animation_size
	set(value):
		if(value >= 1):
			vis_animation_size = value
		else:
			vis_animation_size = 1

## How fast one loop takes in [b]s[/b]
@export_custom(PROPERTY_HINT_NONE, "suffix:s")
var vis_animation_speed: float:
	get: return vis_animation_speed
	set(value): vis_animation_speed = value

## Path to main [annotation @Sprite2D].
@export_node_path("Sprite2D")
var vis_sprite_path: NodePath:
	get: return vis_sprite_path
	set(value): vis_sprite_path = value

var _sprite: Sprite2D:
	get: return _sprite
	set(value): _sprite = value
var _animation_timer: float = 0:
	get: return _animation_timer
	set(value): _animation_timer = fmod(abs(value),vis_animation_size)
var _last_direction: Vector2 = Vector2.DOWN:
	get: return _last_direction.normalized()
	set(value): _last_direction = value.normalized()

# Methodes

## Set all [code]Stats[/code] variables.
func set_all() -> void:
	_current_movement_speed = base_movement_speed
	_current_mult_percent = base_sprint_mult_percent
	_current_max_stamina = base_max_stamina
	_current_stamina = base_max_stamina * 0.5
	_current_stamina_recovery_percent = base_stamina_recovery_percent
	_current_max_health = base_max_health
	_current_health = base_max_health
	_current_health_recovery = base_health_recovery
	_current_resistance = base_resistance
	_current_invincible = base_invincible
	_current_invincible_timer = 0
	_sprite = get_node(vis_sprite_path)
	_sprite.texture = vis_atles
	_sprite.hframes = floori(vis_atles.get_width() / float(vis_square_cell_size))
	_sprite.vframes = floori(vis_atles.get_height() / float(vis_square_cell_size))

## Updates the character's movement
func move_tick(delta: float) -> void:
	var input_direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown", 0.15)

	if (input_direction.length() > 0.1):
		_last_direction = input_direction.normalized()
		velocity = input_direction * _current_movement_speed
	else:
		velocity = Vector2.ZERO

	if (
	Input.is_action_pressed("Sprint") 
	and _current_stamina != 0 
	and velocity.length_squared() >= 0.1
	):
		velocity += (base_sprint_mult_percent/100.0) * velocity
		_current_stamina -= delta
	elif (!Input.is_action_pressed("Sprint") or velocity.length_squared() < 0.1):
		_current_stamina += delta * (base_stamina_recovery_percent/100.0)
		if (velocity.length_squared() < 0.1 and !Input.is_action_pressed("Sprint")):
			var faster_gain = delta
			faster_gain *= _current_max_stamina - _current_stamina
			faster_gain *= (base_stamina_recovery_percent/100.0)
			_current_stamina += faster_gain
	
	move_and_slide()

## Updates the character's sprite
func sprite_tick(delta : float, vel: float = 0.0) -> void:
	var snapped_angle_index: int = roundi(
		_last_direction.angle() * ((_sprite.vframes / 2.0) * (1 / PI)))
	if (snapped_angle_index < 0):
		snapped_angle_index += _sprite.vframes

	_animation_timer += delta * vis_animation_size / vis_animation_speed
	_sprite.modulate = Color(
		1 - (vis_tint.r * _current_invincible_timer) / _current_invincible,
		1 - (vis_tint.g * _current_invincible_timer) / _current_invincible,
		1 - (vis_tint.b * _current_invincible_timer) / _current_invincible,
			1)

	if (vel > 0.25 and Input.is_action_pressed("Sprint") and _current_stamina > 0):
		_sprite.frame_coords = Vector2i(
			2 * vis_animation_size + floori(_animation_timer), snapped_angle_index)
	elif (vel > 0.25 and (not Input.is_action_pressed("Sprint") or _current_stamina <= 0)):
		_sprite.frame_coords = Vector2i(
			vis_animation_size + floori(_animation_timer), snapped_angle_index)
	else:
		_sprite.frame_coords = Vector2i(floori(_animation_timer), snapped_angle_index)

## Damages the player when possible
func damage_tick(delta : float, amount : float) -> void:
	_current_health += _current_health_recovery * delta
	
	if(_current_invincible_timer <= 0):
		_current_health -= amount - _current_resistance
		_current_invincible_timer = _current_invincible
	else:
		_current_invincible_timer -= floori(delta * 1000)
	cheak_death()

## Cheak if the Character if dead. If so, quit.
func cheak_death() -> void:
	if( _current_health <= 0):
		print("DEAD")
		get_tree().call_deferred(&"quit",0)
