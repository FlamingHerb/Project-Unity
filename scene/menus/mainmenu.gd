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


func play_sound():
	pass # Replace with function body.
