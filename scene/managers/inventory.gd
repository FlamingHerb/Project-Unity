extends Node

var current_items = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func add_item(item_id):
	current_items[item_id] = GlobalDatabase.item_database[item_id]
	
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