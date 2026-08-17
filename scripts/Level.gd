extends Node2D

@export var level_data: LevelData

@onready var grid: Grid = $Grid
@onready var board_renderer: BoardRenderer = $BoardRenderer
@onready var player_controller: PlayerController = $PlayerController
@onready var player_view: EntityView = $PlayerView
@onready var object_view_manager: ObjectViewManager = $ObjectViewManager

func _ready() -> void:
	grid.load_level_data(level_data)
	player_controller.setup(grid, level_data.player_start)
	player_controller.moved.connect(_on_player_moved)
	player_view.place_at(level_data.player_start)
	object_view_manager.setup(grid, level_data)
	board_renderer.render(grid)

func _on_player_moved(pushed_object: CellData, object_to: Vector2i) -> void:
	player_controller.input_locked = true
	await _animate_step(pushed_object, object_to)
	while true:
		var next_move := player_controller.try_continue_move()
		if next_move.is_empty():
			break
		await _animate_step(next_move.pushed_object, next_move.object_to)
	board_renderer.render(grid)
	player_controller.input_locked = false

func _animate_step(pushed_object: CellData, object_to: Vector2i) -> void:
	if pushed_object != null:
		object_view_manager.animate_object(pushed_object, object_to)
	await player_view.move_to(player_controller.grid_position)
