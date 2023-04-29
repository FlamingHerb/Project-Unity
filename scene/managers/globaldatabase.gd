extends Node

## The global database of the game.
##
## The following system operates on the same vein as of
## an RPG Maker-made game. It has a switches, it remembers
## the items that you have, and processes any other
## information within the game.
##
## @tutorial:            https://the/tutorial1/url.com
## @tutorial(Tutorial2): https://the/tutorial2/url.com

##===============================================
## Variables
##===============================================

var item_database
var switches = {
	"workroom_dialogue" = false,
	"bedroom_dialogue" = false
}

##===============================================
## Godot Processing functions
##===============================================

# Called when the node enters the scene tree for the first time.
func _ready():
	item_database = read_from_JSON("res://assets/data/item_database.json")
	print(item_database)

##===============================================
## Switch-related functions
##===============================================

## Takes the switch's name and toggles it to the specified boolean value.
func toggle_switch(switch_name, boolean_value):
	switches[switch_name] = boolean_value

## Check's the following switch's boolean value.
func check_switch(switch_name):
	return switches[switch_name]

## Deactivate all switches when going back to the menu.
func reset_switches():
	for index in switches:
		switches[index] = false

##===============================================
## Other related functions
##===============================================

func read_from_JSON(path):
	var file = FileAccess.open(path, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())