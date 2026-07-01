extends BasePlayer

func _ready() -> void:
	set_all()

func _physics_process(delta: float) -> void:
	move_tick(delta)
	sprite_tick(delta, velocity.length())
	damage_tick(delta, 0)
