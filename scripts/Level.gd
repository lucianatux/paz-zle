extends Node2D

@export var level_data: LevelData

@onready var grid: Grid = $Grid

func _ready() -> void:
	grid.load_level_data(level_data)
	print("Grid cargado. Occupants: ", grid.occupants)
