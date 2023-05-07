extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_quit_button_pressed():
	$QuitGameModal.show()


func _on_back_button_pressed():
	get_tree().paused = false
	hide()


func _on_settings_pressed():
	$Settings.show()

func _on_main_menu_button_pressed():
	$ReturnToMainMenu.show()


func _on_visibility_changed():
	if self.is_visible():
		$Settings.load_settings()



func _on_main_menu_no_pressed():
	$ReturnToMainMenu.hide()

func _on_main_menu_yes_pressed():
	$ReturnToMainMenu.hide()
	hide()
	get_tree().paused = false
	SceneManager.goto_scene("res://scene/menus/mainmenu.tscn")
	GamePauseUI.toggle_ui(false)
	DialogueScreen.toggle_ui(false)

	Inventory.reset()
	GlobalDatabase.reset_switches()
	GamePauseUI.clear_textlog()



func _on_quit_no_pressed():
	$QuitGameModal.hide()

func _on_quit_yes_pressed():
	get_tree().quit()


func _on_save_button_pressed():
	$SaveGame.show()
