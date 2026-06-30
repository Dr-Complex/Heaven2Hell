@abstract class_name PlayerItemResource
extends Resource

@export_category("Base")
@export_range(0, 10, 1, "or_greater") var id: int = 0
@export var name: String = ""
@export_range(0, 10, 1, "or_greater") var level: int = 0
@export_flags("Weapon:1", "Passive:2", "Tempory:4", "Cursed:8") var type = 0

@abstract func alter()
