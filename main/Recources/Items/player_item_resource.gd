@abstract class_name PlayerItemResource
extends Resource

@export_category("Base")
@export_range(0, 10, 1, "or_greater") var id: int = 0
@export_placeholder("Name it!") var name: String
@export_range(0, 10, 1, "or_greater") var level: int = 0
@export_flags("Weapon", "Buff", "Cursed") var type : int= 0
