extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_button_pressed():
	hide()


func _on_new_game_button_pressed():
	SceneManager.goto_scene("res://scene/levels/junction.tscn")
	GamePauseUI.toggle_ui(true)
	DialogueScreen.toggle_ui(true)
	#GamePauseUi.get_node("PauseCanvasLayer").show() # This has to be the most shittiest way to do stuff oml
