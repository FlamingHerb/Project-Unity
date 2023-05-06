extends Control

@onready var text_time_played = $SaveData/TimePlayed
@onready var text_location = $SaveData/Location

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_back_button_pressed():
	$SaveImage.texture = null
	text_time_played.text = ""
	text_location.text = ""
	hide()


func _on_inventory_pressed():
	pass # Replace with function body.


func _on_save_list_item_activated(index:int):
	pass # Replace with function body.


func _on_visibility_changed():
	if self.is_visible():
		for index in range(0,3):
			if FileAccess.file_exists("user://savegame_" + str(index) + ".save"):
				$SaveList.set_item_disabled(index, false)
			else:
				$SaveList.set_item_disabled(index, true)


func _on_save_list_item_clicked(index, _at_position, _mouse_button_index):
	if not FileAccess.file_exists("user://savegame_" + str(index) + ".save"):
		return

	# Load image
	var image = Image.new()
	image.load("user://savescreen_" + str(index) + ".png")
	$SaveImage.texture = ImageTexture.create_from_image(image)

	# Load data
	var load_data = FileAccess.open("user://savegame_" + str(index) + ".save", FileAccess.READ)
	var json = JSON.new()
	json.parse(load_data.get_line())

	# Parse data and use it.
	var global_database_data = json.get_data()
	#print(global_database_data)

	text_time_played.text = global_database_data["save_date"]
	text_location.text = global_database_data["location"]
