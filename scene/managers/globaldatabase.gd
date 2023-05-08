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
var location
var current_location
var save_screenshot

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

func save_data():
	var global_database = {
		"name": "GlobalDatabase",
		"switches": switches,
		"save_date": Time.get_datetime_string_from_system(false,true),
		"location": location,
		"current_location": current_location,
	}
	return global_database

func load_data(dict_data):
	switches = dict_data["switches"]

func get_save_screenshot():
	save_screenshot = get_viewport().get_texture().get_image()
	save_screenshot.resize(312,176)

func set_flavor_location(flavor_loc):
	print("Going to " + flavor_loc)
	location = flavor_loc

func set_node_location(node_loc):
	current_location = node_loc
	print("Node path set to: " + node_loc)