class_name Grid
extends Node

const BOARD_WIDTH := 16
const BOARD_HEIGHT := 9

var walls: Dictionary = {}       # Vector2i -> true
var exit_position: Vector2i = Vector2i(-1, -1)
var occupants: Dictionary = {}   # Vector2i -> CellData

func is_valid_position(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.x < BOARD_WIDTH and pos.y >= 0 and pos.y < BOARD_HEIGHT

func is_wall(pos: Vector2i) -> bool:
	return walls.has(pos)

func is_exit(pos: Vector2i) -> bool:
	return pos == exit_position

func is_walkable(pos: Vector2i) -> bool:
	if not is_valid_position(pos):
		return false
	if is_wall(pos):
		return false
	if occupants.has(pos):
		var cell: CellData = occupants[pos]
		match cell.type:
			CellData.Type.OBJECT:
				return false
			CellData.Type.PLAYER:
				return false
			CellData.Type.NPC:
				return not CellData.is_conflictive_mood(cell.mood)
	return true

func get_entity_at(pos: Vector2i) -> CellData:
	return occupants.get(pos)

func move_entity(from: Vector2i, to: Vector2i) -> bool:
	if not occupants.has(from):
		return false
	var cell: CellData = occupants[from]
	occupants.erase(from)
	occupants[to] = cell
	return true

func push(object_pos: Vector2i, direction: Vector2i) -> bool:
	var beyond: Vector2i = object_pos + direction
	if not is_walkable(beyond):
		return false
	move_entity(object_pos, beyond)
	return true

func load_level_data(data: LevelData) -> void:
	walls.clear()
	for wall_pos in data.walls:
		walls[wall_pos] = true
	exit_position = data.exit_position
	occupants.clear()
	occupants[data.player_start] = CellData.for_player()
	for npc: NpcSpawnData in data.npcs:
		occupants[npc.position] = CellData.for_npc(npc.id, npc.mood)
	for obj: ObjectSpawnData in data.objects:
		occupants[obj.position] = CellData.for_object(obj.object_type)
