extends Control

@onready var the_item_list = $ItemList

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_item_list_item_selected(index:int):
	var current_item = Inventory.current_items[the_item_list.get_item_text(index)]
	print(current_item["description"])
	
func _on_back_button_pressed():
	get_tree().paused = false
	hide()

func _add_items_to_item_list():
	for item in Inventory.current_items:
		the_item_list.add_item(item)

func _on_visibility_changed():
	if self.is_visible():
		the_item_list.clear()
		_add_items_to_item_list()
