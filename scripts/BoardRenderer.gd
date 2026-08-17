class_name BoardRenderer
extends Node2D

const CELL_SIZE := 128

@export var exit_texture: Texture2D
@export var wall_texture: Texture2D

func render(grid: Grid) -> void:
	for child in get_children():
		child.queue_free()

	_draw_cell(grid.exit_position, exit_texture)

	for wall_pos in grid.walls:
		_draw_cell(wall_pos, wall_texture)

func _draw_cell(pos: Vector2i, texture: Texture2D) -> void:
	if texture == null:
		return
	var sprite := Sprite2D.new()
	sprite.texture = texture
	sprite.position = Vector2(pos.x * CELL_SIZE + CELL_SIZE / 2.0, pos.y * CELL_SIZE + CELL_SIZE / 2.0)
	add_child(sprite)
