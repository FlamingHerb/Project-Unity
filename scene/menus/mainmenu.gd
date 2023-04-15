extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#===============================================================================
# START: BUTTONS
#===============================================================================

func _on_new_game_pressed():
	$NewGame.show()
	$"/root/AudioManager".play_click()

func _on_load_game_pressed():
	$LoadGame.show()
	$"/root/AudioManager".play_click()

func _on_settings_pressed():
	$Settings.show()
	$"/root/AudioManager".play_click()

func _on_help_pressed():
	$Help.show()
	$"/root/AudioManager".play_click()

func _on_about_pressed():
	$About.show()
	$"/root/AudioManager".play_click()

func _on_exit_pressed():
	get_tree().quit()
	$"/root/AudioManager".play_click()

#===============================================================================
# END: BUTTONS
#===============================================================================


func play_sound():
	pass # Replace with function body.
