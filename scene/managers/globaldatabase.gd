extends Node

var item_database
var switches = {
	"workroom_dialogue" = false,
	"bedroom_dialogue" = false
}

# Called when the node enters the scene tree for the first time.
func _ready():
	item_database = read_from_JSON("res://assets/data/item_database.json")
	print(item_database)

func read_from_JSON(path):
	var file = FileAccess.open(path, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())

## Takes the switch's name and toggles it to the specified boolean value.
func toggle_switch(switch_name, boolean_value):
	switches[switch_name] = boolean_value

## Check's the following switch's boolean value.
func check_switch(switch_name):
	return switches[switch_name]