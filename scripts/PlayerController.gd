class_name PlayerController
extends Node

signal moved(pushed_object: CellData, object_to: Vector2i)

var grid: Grid
var grid_position: Vector2i
var input_locked: bool = false

func setup(p_grid: Grid, start_position: Vector2i) -> void:
	grid = p_grid
	grid_position = start_position

func _unhandled_input(event: InputEvent) -> void:
	if input_locked:
		return
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

func try_continue_move() -> Dictionary:
	var direction := _get_pressed_direction()
	if direction == Vector2i.ZERO:
		return {}
	return _attempt_move(direction)

func _get_pressed_direction() -> Vector2i:
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		return Vector2i.RIGHT
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		return Vector2i.LEFT
	if Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W):
		return Vector2i.UP
	if Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S):
		return Vector2i.DOWN
	return Vector2i.ZERO

func _try_move(direction: Vector2i) -> void:
	var result := _attempt_move(direction)
	if result.is_empty():
		return
	moved.emit(result.pushed_object, result.object_to)

func _attempt_move(direction: Vector2i) -> Dictionary:
	var target := grid_position + direction
	if grid.is_walkable(target):
		grid.move_entity(grid_position, target)
		grid_position = target
		return {"pushed_object": null, "object_to": Vector2i.ZERO}
	var entity: CellData = grid.get_entity_at(target)
	if entity != null and entity.type == CellData.Type.OBJECT:
		var object_to := target + direction
		if grid.push(target, direction):
			grid.move_entity(grid_position, target)
			grid_position = target
			return {"pushed_object": entity, "object_to": object_to}
	return {}
