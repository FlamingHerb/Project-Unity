extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_quit_button_pressed():
	get_tree().quit()


func _on_back_button_pressed():
	get_tree().paused = false
	hide()


func _on_settings_pressed():
	$OtherMenuModals/Settings.show()

func _on_main_menu_button_pressed():
	hide()
	get_tree().paused = false
	SceneManager.goto_scene("res://scene/menus/mainmenu.tscn")
	GamePauseUI.toggle_ui(false)
	DialogueScreen.toggle_ui(false)

	Inventory.reset()
	GlobalDatabase.reset_switches()
	GamePauseUI.clear_textlog()
