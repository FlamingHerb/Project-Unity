extends Node

## The inventory system of the game.
##
## This system tracks the current items that the player
## has, in order to keep track of a few things.
##
## @tutorial:            https://the/tutorial1/url.com
## @tutorial(Tutorial2): https://the/tutorial2/url.com

##===============================================
## Variables
##===============================================

## Holds the current items the player has.
var current_items = {}

##===============================================
## Godot Processing functions
##===============================================

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

##===============================================
## Item-related functions
##===============================================

## Adds the following item based on its dictionary input.
func add_item(item_id):
	current_items[item_id] = GlobalDatabase.item_database[item_id]

## Checks if the following item exists based on its dictionary input.
func check_item(item_id):
	if current_items and current_items.has(item_id):
		print("The following item is present.")
		return true
	else:
		print("The following item is absent.")
		return false

## Resets current inventory when going to the menu... or just a general reset overall.
func reset():
	current_items = {}

func save_data():
	var inven = {
		"name": "Inventory",
		"current_items": current_items,
	}
	return inven

func load_data(dict_data):
	current_items = dict_data["current_items"]