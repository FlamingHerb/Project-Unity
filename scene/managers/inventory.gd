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