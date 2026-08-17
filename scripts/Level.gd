extends Node2D

@export var level_data: LevelData

@onready var grid: Grid = $Grid
@onready var board_renderer: BoardRenderer = $BoardRenderer
@onready var player_controller: PlayerController = $PlayerController
@onready var player_view: EntityView = $PlayerView

func _ready() -> void:
	grid.load_level_data(level_data)
	player_controller.setup(grid, level_data.player_start)
	player_controller.moved.connect(_on_player_moved)
	player_view.place_at(level_data.player_start)
	board_renderer.render(grid)
	

func _on_player_moved() -> void:
	player_controller.input_locked = true
	await player_view.move_to(player_controller.grid_position)
	board_renderer.render(grid)
	player_controller.input_locked = false
