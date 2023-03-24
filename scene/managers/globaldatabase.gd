extends Node

var item_database

# Called when the node enters the scene tree for the first time.
func _ready():
	item_database = read_from_JSON("res://assets/data/item_database.json")
	print(item_database)

func read_from_JSON(path):
	var file = FileAccess.open("res://assets/data/item_database.json", FileAccess.READ)
	return JSON.parse_string(file.get_as_text())
