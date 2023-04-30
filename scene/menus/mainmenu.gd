extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play_music()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#===============================================================================
# START: BUTTONS
#===============================================================================

func _on_new_game_pressed():
	SceneManager.goto_level_scene("intro/detective_workshop.tscn")
	GamePauseUI.toggle_ui(true)
	DialogueScreen.toggle_ui(true)
	AudioManager.stop_music()

func _on_load_game_pressed():
	$LoadGame.show()

func _on_settings_pressed():
	$Settings.show()

func _on_help_pressed():
	$Help.show()

func _on_about_pressed():
	$About.show()

func _on_exit_pressed():
	get_tree().quit()

#===============================================================================
# END: BUTTONS
#===============================================================================
