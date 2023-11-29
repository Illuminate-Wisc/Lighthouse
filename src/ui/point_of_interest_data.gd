extends Node


const POI_JSON_PATH = "res://src/data/poi.json"

@onready var info: Dictionary = JSON.parse_string(
		FileAccess.get_file_as_string(POI_JSON_PATH)
	)


func get_info(poi_name: String) -> PackedStringArray:
	if poi_name not in info:
		print("DEBUG: POI name not found: ", poi_name)
		return []
	
	return info[poi_name]
