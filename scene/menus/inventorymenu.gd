extends Control

@onready var the_item_list = $ItemList
@onready var item_picture = $ItemPicture
@onready var item_name = $ItemName
@onready var item_description = $ItemDescription
var asset_path = "res://assets/graphics/items/"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_item_list_item_selected(index:int):
	var selected_item_name = the_item_list.get_item_text(index)
	var current_item = Inventory.current_items[selected_item_name]
	item_name.text = selected_item_name
	item_picture.texture = load(asset_path + current_item["image"] + ".png")
	item_description.text = current_item["description"]
	
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


func _on_hidden():
	item_name.text = ""
	item_picture.texture = null
	item_description.text = ""
