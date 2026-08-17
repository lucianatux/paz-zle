extends Node2D

@export var level_data: LevelData

@onready var grid: Grid = $Grid
@onready var board_renderer: BoardRenderer = $BoardRenderer
@onready var player_controller: PlayerController = $PlayerController

func _ready() -> void:
	grid.load_level_data(level_data)
	player_controller.setup(grid, level_data.player_start)
	player_controller.moved.connect(_on_player_moved)
	board_renderer.render(grid)

func _on_player_moved() -> void:
	board_renderer.render(grid)
