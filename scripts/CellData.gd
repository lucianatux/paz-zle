class_name CellData
extends RefCounted

enum Type { PLAYER, NPC, OBJECT }
enum Mood { PEACE, SADNESS, ANGER }
enum ObjectType { FLOWER }

var type: Type
var id: String = ""
var mood: Mood = Mood.PEACE
var object_type: ObjectType = ObjectType.FLOWER

static func for_player() -> CellData:
	var cell := CellData.new()
	cell.type = Type.PLAYER
	return cell

static func for_npc(npc_id: String, npc_mood: Mood) -> CellData:
	var cell := CellData.new()
	cell.type = Type.NPC
	cell.id = npc_id
	cell.mood = npc_mood
	return cell

static func for_object(obj_type: ObjectType) -> CellData:
	var cell := CellData.new()
	cell.type = Type.OBJECT
	cell.object_type = obj_type
	return cell

static func is_conflictive_mood(m: Mood) -> bool:
	return m != Mood.PEACE
