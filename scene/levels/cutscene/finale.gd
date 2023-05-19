extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	_cutscene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _cutscene():
	$AnimationPlayer.play("cutscene")

func _switch_to_game():
	SceneManager.goto_scene("res://scene/menus/mainmenu.tscn")
	GamePauseUI.toggle_ui(false)
	DialogueScreen.toggle_ui(false)

	Inventory.reset()
	GlobalDatabase.reset_switches()
	GamePauseUI.clear_textlog()