class_name BasePlayer
extends CharacterBody2D
## The base for every character
##
## This class inclueds all essential variables and methodes.
##

var enable_self_ticks: bool = true

# Stats
@export_group("Stats","base_")

## Movement speed, in [b]px/s[/b], of the player
@export_range(0,1,0.1,"hide_control","or_greater","suffix:px/s")
var base_movement_speed: float :
	get: return base_movement_speed
	set(value): 
		if(value >= 0):
			if(value < current_movement_speed):
				current_movement_speed = value
			base_movement_speed = value
		else:
			current_movement_speed = 0
			base_movement_speed = 0

## The percent of [param _base_movement_speed] added to itself when holding down [kbd]Ctrl[/kbd]
@export_range(-1000,1000,0.1,"hide_control","suffix:%")
var base_sprint_mult_percent: float :
	get: return base_sprint_mult_percent
	set(value): 
		if(abs(value) <= 1000):
			if (abs(value) <= current_mult_percent):
				current_mult_percent = value
			base_sprint_mult_percent = value
		else:
			current_mult_percent = 1000 * sign(value)
			base_sprint_mult_percent = 1000 * sign(value)

## How long [kbd]Ctrl[/kbd] can be held down consequently 
@export_range(0,1,0.1,"hide_control","or_greater","suffix:s")
var base_max_stamina: float :
	get: return base_max_stamina
	set(value):
		if(value >= 0):
			if (value <= current_max_stamina):
				current_max_stamina = value
			base_max_stamina = value
		else:
			current_max_stamina = 0
			base_max_stamina = 0

## Base and starting health of the character
@export_range(1,2,1,"hide_control","or_greater")
var base_max_health: float :
	get: return base_max_health
	set(value):
		if(value >= 1):
			if(value <= current_max_health):
				current_max_health = value
			base_max_health = value
		else:
			current_max_health = 1
			base_max_health = 1

## Stamina recovery, in [b]%/s[/b]
@export_range(-1000,1000,0.1,"hide_control","suffix:%/s")
var base_stamina_recovery_percent: float:
	get: return base_stamina_recovery_percent
	set(value):
		if (abs(value) <= 1000):
			if(abs(value) <= current_stamina_recovery_percent):
				current_stamina_recovery_percent = value
			base_stamina_recovery_percent = value
		else:
			current_stamina_recovery_percent = 1000 * sign(value)
			base_stamina_recovery_percent = 1000 * sign(value)

## Health recovery, in [b]1/s[/b]
@export_range(0,1,0.1,"hide_control","or_greater","suffix:/s")
var base_health_recovery: float:
	get: return base_health_recovery
	set(value):
		if (value >= 0):
			if(value <= current_health_recovery):
				current_health_recovery = value
			base_health_recovery = value
		else:
			current_health_recovery = 0
			base_health_recovery = 0

## Damage reduction ([code]x > 0[/code]) or increaser ([code]x < 0[/code])
@export_range(0,1,0.1,"hide_control","or_less","or_greater","suffix:%")
var base_resistance: float:
	get: return base_resistance
	set(value):
		current_resistance = value
		base_resistance = value

## Invincible in ms
@export_range(0,15000,0.1,"hide_control","suffix:ms")
var base_invincible: float:
	get: return base_invincible
	set(value):
		if(value>=0 and value <= 15000):
			if(value <= current_invincible):
				current_invincible = value
			base_invincible = value
		elif(value <= 0):
			current_invincible = 0
			base_invincible = 0
		else:
			current_invincible = 15000
			base_invincible = 15000

var current_movement_speed: float:
	get: return current_movement_speed
	set(value): 
		if(value >= 0):
			current_movement_speed = value
		else:
			current_movement_speed = 0
var current_mult_percent: float:
	get: return current_mult_percent
	set(value): 
		if(abs(value) <= 1000):
			current_mult_percent = value
		else:
			current_mult_percent = 1000 * sign(value)
var current_max_stamina: float:
	get: return current_max_stamina
	set(value):
		if (value >= 0):
			current_max_stamina = value
		else:
			current_max_stamina = 0
var current_max_health: float:
	get: return current_max_health
	set(value):
		if(value >= 1):
			current_max_health = value
		else:
			current_max_health = 1
var current_stamina_recovery_percent: float:
	get: return current_stamina_recovery_percent
	set(value):
		if (abs(value) <= 1000):
			current_stamina_recovery_percent = value
		else:
			current_stamina_recovery_percent = 1000 * sign(value)
var current_health_recovery: float:
	get: return current_health_recovery
	set(value):
		if (value >= 0):
			current_health_recovery = value
		else:
			current_health_recovery = 0
var current_resistance: float:
	get: return current_resistance
	set(value): current_resistance = value
var current_invincible: float:
	get: return current_invincible
	set(value):
		if(value >= 0 and value <= 15000):
			current_invincible = value
		elif(value <= 0):
			current_invincible = 0
		else:
			current_invincible = 15000
var current_stamina: float:
	get: return current_stamina
	set(value): 
		if (value <= current_max_stamina and value >= 0):
			current_stamina = value
		elif (value <= 0):
			current_stamina = 0
		else:
			current_stamina = current_max_stamina
var current_health: float:
	get: return current_health
	set(value):
		if(value >= 0 and value <= current_max_health):
			current_health = value
		elif(value <= 0):
			current_health = 0
		else :
			current_health = current_max_health
var current_invincible_timer: float:
	get: return current_invincible_timer
	set(value):
		if(value >= 0):
			current_invincible_timer = value
		else:
			current_invincible_timer = 0


# Visuals
@export_group("Visuals", "vis_")

## The full atles of sprites for character
@export
var vis_atles: Texture2D:
	get: return vis_atles
	set(value): vis_atles = value

## Each cell of the animation [b]MUST BE[/b] square [b]AND[/b] the same size.
@export_range(1,2,1,"hide_control","or_greater","suffix:px")
var vis_square_frame_size: int:
	get: return vis_square_frame_size
	set(value):
		if(value >= 1):
			vis_square_frame_size = value
		else:
			vis_square_frame_size = 1

## How many frams in one animation loop.
@export_custom(PROPERTY_HINT_NONE, "suffix:frames")
var vis_animation_size: int:
	get: return vis_animation_size
	set(value):
		if(value >= 1):
			vis_animation_size = value
		else:
			vis_animation_size = 1

## How fast one loop takes in [b]s[/b].
@export_custom(PROPERTY_HINT_NONE, "suffix:s")
var vis_animation_speed: float:
	get: return vis_animation_speed
	set(value): vis_animation_speed = value

## [annotation @Sprite2D] for the character.
@export
var vis_sprite: Sprite2D:
	get: return vis_sprite
	set(value): vis_sprite = value

## [annotation @ProgressBar] for the character's Health and Stamina.
@export
var vis_progress_bars: Array[ProgressBar]:
	get: return vis_progress_bars
	set(value): vis_progress_bars = value

var _animation_timer: float = 0:
	get: return _animation_timer
	set(value): _animation_timer = fmod(abs(value),vis_animation_size)
var _last_direction: Vector2 = Vector2.DOWN:
	get: return _last_direction.normalized()
	set(value): _last_direction = value.normalized()

# Methodes

func _ready() -> void:
	current_movement_speed = base_movement_speed
	current_mult_percent = base_sprint_mult_percent
	current_max_stamina = base_max_stamina
	current_stamina = base_max_stamina * 0.5
	current_stamina_recovery_percent = base_stamina_recovery_percent
	current_max_health = base_max_health
	current_health = base_max_health
	current_health_recovery = base_health_recovery
	current_resistance = base_resistance
	current_invincible = base_invincible
	current_invincible_timer = 0
	
	vis_sprite.texture = vis_atles
	vis_sprite.hframes = floori(vis_atles.get_width() / float(vis_square_frame_size))
	vis_sprite.vframes = floori(vis_atles.get_height() / float(vis_square_frame_size))
	
	vis_progress_bars.get(0).min_value = 0
	vis_progress_bars.get(1).min_value = 0

func _process(delta: float) -> void:
	if (enable_self_ticks):
		movement_tick(delta)
	else: return

## Updates the character's movement.
func movement_tick(delta: float) -> void:
	var input_direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown", 0.15)

	if (input_direction.length() > 0.1):
		_last_direction = input_direction.normalized()
		velocity = input_direction * current_movement_speed
		if (abs(roundi(fmod(_last_direction.angle(),PI / 2.0))) == 1):
			velocity.y *= 0.5
			velocity *= sqrt(2)
	else:
		velocity = Vector2.ZERO

	if (
	Input.is_action_pressed("Sprint") 
	and current_stamina != 0 
	and velocity.length_squared() >= 0.1
	):
		velocity *= (100 + current_mult_percent)/100.0
		current_stamina -= delta
	elif (!Input.is_action_pressed("Sprint") or velocity.length_squared() < 0.1):
		current_stamina += delta * (current_stamina_recovery_percent/100.0)
		if (velocity.length_squared() < 0.1 and !Input.is_action_pressed("Sprint")):
			var faster_gain = delta
			faster_gain *= (current_max_stamina - current_stamina)
			faster_gain *= (current_stamina_recovery_percent/100.0)
			current_stamina += faster_gain
	
	sprite_tick(delta, velocity.length())
	move_and_slide()

## Updates the character's sprite.
func sprite_tick(delta : float, vel: float = 0.0) -> void:
	var snapped_angle_index: int = roundi(
		_last_direction.angle() * ((vis_sprite.vframes / 2.0) * (1 / PI)))
	if (snapped_angle_index < 0):
		snapped_angle_index += vis_sprite.vframes
	
	_animation_timer += delta * vis_animation_size / vis_animation_speed
	
	if (vel > 0.25 and Input.is_action_pressed("Sprint") and current_stamina > 0):
		vis_sprite.frame_coords = Vector2i(
			2 * vis_animation_size + floori(_animation_timer), snapped_angle_index)
	elif (vel > 0.25 and (not Input.is_action_pressed("Sprint") or current_stamina <= 0)):
		vis_sprite.frame_coords = Vector2i(
			vis_animation_size + floori(_animation_timer), snapped_angle_index)
	else:
		vis_sprite.frame_coords = Vector2i(floori(_animation_timer), snapped_angle_index)
	
	vis_progress_bars.get(0).max_value = current_max_health
	vis_progress_bars.get(1).max_value = current_max_stamina
	
	vis_progress_bars.get(0).value = current_health
	vis_progress_bars.get(1).value = current_stamina

## Damages the player when possible.
func take_damage(delta : float, amount : float) -> void:
	current_health += current_health_recovery * delta
	
	if(current_invincible_timer <= 0 and amount >= 0):
		current_health -= (amount * (1 - (current_resistance/100.0)) * delta)
		current_invincible_timer = current_invincible
	elif(current_invincible_timer > 0 or amount >= 0):
		current_invincible_timer -= floori(delta * 1000)
	cheak_death()

## Check if the Character if dead. If so, quit.
func cheak_death() -> void:
	if(current_health <= 0):
		print("DEAD")
		get_tree().call_deferred(&"quit",0)

## Check if the player is out of bounds
func limit_position():
	pass
