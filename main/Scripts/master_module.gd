extends Node

@export var _seleted_seed: int = 0
@onready var random_values := RandomNumberGenerator.new()

func _ready() -> void:
	if (_seleted_seed == 0):
		_seleted_seed = Time.get_time_dict_from_system().hour * 3600
		_seleted_seed += Time.get_time_dict_from_system().minute * 60
		_seleted_seed += Time.get_time_dict_from_system().second
	random_values.seed = _seleted_seed
