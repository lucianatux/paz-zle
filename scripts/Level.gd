extends Node2D

@export var level_data: LevelData

@onready var grid: Grid = $Grid
@onready var board_renderer: BoardRenderer = $BoardRenderer

func _ready() -> void:
	grid.load_level_data(level_data)
	board_renderer.render(grid)
