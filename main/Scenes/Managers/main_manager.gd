class_name MainManager
extends Node

var _seleted_seed: int = 0
@export var player_node : BasePlayer
@export var back_drop_node: BackDrop


## Used for RNG for the game
var random_values: RandomNumberGenerator:
	get: return random_values
	set(value):
		if (not random_values or random_values.seed == 0):
			random_values = value
		else:
			printerr("CAN NOT DO THAT")
var random_noise : FastNoiseLite:
	get: return random_noise
	set(value):
		if(random_noise):
			if (random_noise.seed != value.seed):
				random_noise = value
			else:
				printerr("new rng seed for noise")
				random_noise = FastNoiseLite.new()
		else:
			random_noise = value

func _ready() -> void:
	random_values = RandomNumberGenerator.new()
	random_noise = FastNoiseLite.new()
	if (_seleted_seed == 0):
		_seleted_seed = Time.get_time_dict_from_system().hour * 3600
		_seleted_seed += Time.get_time_dict_from_system().minute * 60
		_seleted_seed += Time.get_time_dict_from_system().second
	random_values.seed = _seleted_seed
	random_noise.seed = _seleted_seed
	random_noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	
	player_node.enable_self_ticks = false

func _process(delta: float) -> void:
	player_node.movement_tick(delta)
	back_drop_node.tiles_tick(delta)
