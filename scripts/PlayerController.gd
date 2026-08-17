class_name PlayerController
extends Node

signal moved

var grid: Grid
var grid_position: Vector2i

func setup(p_grid: Grid, start_position: Vector2i) -> void:
	grid = p_grid
	grid_position = start_position

func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo:
		return
	var direction := Vector2i.ZERO
	match event.keycode:
		KEY_RIGHT, KEY_D:
			direction = Vector2i.RIGHT
		KEY_LEFT, KEY_A:
			direction = Vector2i.LEFT
		KEY_UP, KEY_W:
			direction = Vector2i.UP
		KEY_DOWN, KEY_S:
			direction = Vector2i.DOWN
	if direction != Vector2i.ZERO:
		_try_move(direction)

func _try_move(direction: Vector2i) -> void:
	var target := grid_position + direction
	if grid.is_walkable(target):
		grid.move_entity(grid_position, target)
		grid_position = target
		moved.emit()
		return
	var entity: CellData = grid.get_entity_at(target)
	if entity != null and entity.type == CellData.Type.OBJECT:
		if grid.push(target, direction):
			grid.move_entity(grid_position, target)
			grid_position = target
			moved.emit()
