class_name WeaponMarker
extends Marker2D

var id: int
var weapon_name: String
var level: int
var cooldown: float
var delta_timer: float = 0.0
var spawn_pattern: Pattern
var bullet_properties: BulletProps


func _init() -> void:
	id = 0
	cooldown = 1
	weapon_name = "thing"
	level = 0
	self.name = "%1s lv.%2s" % [weapon_name, level]
	bullet_properties = null
	spawn_pattern = null

func _ready() -> void:
	spawn_pattern.bullet = weapon_name

	Spawning.new_pattern(
		weapon_name,
		Spawning.sanitize_pattern(spawn_pattern, self),
	)

	Spawning.new_bullet(
		weapon_name,
		Spawning.sanitize_bulletprops(bullet_properties, weapon_name, self),
	)

	Spawning.create_shared_area(weapon_name + "_area", 0x00_00_00_04, 0x00_00_00_20)
	Spawning.get_shared_area(weapon_name + "_area").set_meta(StringName("ShapeCount"), 0)
	Spawning.get_shared_area(weapon_name + "_area").set_meta(StringName("Bullets"), { })

	Spawning.create_pool(weapon_name, 128, weapon_name + "_area")

func shoot() -> void:
	print("===\t%s\t===" % name)

func update() -> void:
	print("I must update now\t\t\tBut I can not now")
