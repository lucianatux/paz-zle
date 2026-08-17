class_name EntityView
extends Node2D

const CELL_SIZE := 128
const MOVE_DURATION := 0.1

func place_at(grid_pos: Vector2i) -> void:
	position = _grid_to_pixel(grid_pos)

func move_to(grid_pos: Vector2i):
	var target := _grid_to_pixel(grid_pos)
	var tween := create_tween()
	tween.tween_property(self, "position", target, MOVE_DURATION).set_trans(Tween.TRANS_SINE)
	await tween.finished

func _grid_to_pixel(grid_pos: Vector2i) -> Vector2:
	return Vector2(grid_pos.x * CELL_SIZE + CELL_SIZE / 2.0, grid_pos.y * CELL_SIZE + CELL_SIZE / 2.0)
