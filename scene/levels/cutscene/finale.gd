extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	_cutscene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if Input.is_action_pressed("ui_accept") or GlobalDatabase.is_mouse_clicked(event):
		if $AnimationPlayer.current_animation_position < 29:
			$AnimationPlayer.seek(29, true)

func _cutscene():
	$AnimationPlayer.play("cutscene")
	

func _switch_to_game():
	#SceneManager.goto_scene("res://scene/menus/mainmenu.tscn")
	# GamePauseUI.toggle_ui(false)
	# DialogueScreen.toggle_ui(false)

	# Inventory.reset()
	# GlobalDatabase.reset_switches()
	# GamePauseUI.clear_textlog()

  SceneManager.goto_level_scene("cutscene/news.tscn")
