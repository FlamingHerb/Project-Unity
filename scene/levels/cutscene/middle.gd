extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	_cutscene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if Input.is_action_pressed("ui_accept") or GlobalDatabase.is_mouse_clicked(event):
		$AnimationPlayer.seek(49.5, true)

func _cutscene():
	$AnimationPlayer.play("cutscene")

func _switch():
	SceneManager.goto_level_scene("intro/detective_bedroom.tscn")
	GamePauseUI.toggle_ui(true)
	DialogueScreen.toggle_ui(true)