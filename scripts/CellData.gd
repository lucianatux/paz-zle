class_name CellData
extends RefCounted

enum Type { JUGADOR, NPC, OBJETO }
enum Mood { PAZ, TRISTEZA, IRA }

var type: Type
var id: String = ""
var mood: Mood = Mood.PAZ

func _init(p_type: Type, p_id: String = "", p_mood: Mood = Mood.PAZ) -> void:
	type = p_type
	id = p_id
	mood = p_mood

static func is_conflictive_mood(m: Mood) -> bool:
	return m != Mood.PAZ
