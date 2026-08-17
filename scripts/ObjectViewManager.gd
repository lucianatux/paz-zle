class_name ObjectViewManager
extends Node2D

const OBJECT_VIEW_SCENE := preload("res://scenes/object_view.tscn")
const SPRITE_CHILD_NAME := "Sprite2D"

@export var flower_texture: Texture2D

var views: Dictionary = {}  # CellData -> EntityView

func setup(grid: Grid, level_data: LevelData) -> void:
	for obj: ObjectSpawnData in level_data.objects:
		var cell: CellData = grid.get_entity_at(obj.position)
		var view: EntityView = OBJECT_VIEW_SCENE.instantiate()
		add_child(view)
		view.place_at(obj.position)
		var sprite: Sprite2D = view.get_node(SPRITE_CHILD_NAME)
		sprite.texture = _get_texture(cell.object_type)
		views[cell] = view

func animate_object(object_cell: CellData, to: Vector2i) -> void:
	var view: EntityView = views.get(object_cell)
	if view:
		await view.move_to(to)

func _get_texture(object_type: CellData.ObjectType) -> Texture2D:
	match object_type:
		CellData.ObjectType.FLOWER:
			return flower_texture
		_:
			return null
