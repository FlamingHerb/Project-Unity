extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_back_button_pressed():
	hide()

## Saves game
func _on_save_list_item_activated(index:int):
	var save_game = FileAccess.open("user://savegame_" + str(index) + ".save", FileAccess.WRITE)
	GlobalDatabase.save_screenshot.save_png("user://savescreen_" + str(index) + ".png")
	save_game.store_line(JSON.stringify(GlobalDatabase.save_data())) # Saves GlobalDatabase data
	save_game.store_line(JSON.stringify(Inventory.save_data())) # Saves Inventory data
	print("Save " + str(index) + " Successful!")

func _on_save_list_item_selected(index:int):
	if not FileAccess.file_exists("user://savegame_" + str(index) + ".save"):
		$SaveImage.texture = null
		return
	var image = Image.new()
	image.load("user://savescreen_" + str(index) + ".png")
	$SaveImage.texture = ImageTexture.create_from_image(image)
	#$SaveImage.texture = load(OS.get_user_data_dir() + "/savescreen_" + str(index) + ".png")