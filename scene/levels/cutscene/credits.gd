extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_pressed("ui_accept") or GlobalDatabase.is_mouse_clicked(event):
		GamePauseUI.toggle_ui(false)
		DialogueScreen.toggle_ui(false)

		Inventory.reset()
		GlobalDatabase.reset_switches()
		GamePauseUI.clear_textlog()
		SceneManager.goto_scene("res://scene/menus/mainmenu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
