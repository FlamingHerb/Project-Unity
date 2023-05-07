extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	_cutscene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _cutscene():
	$AnimationPlayer.play("cutscene")

func _switch():
	SceneManager.goto_level_scene("intro/detective_bedroom.tscn")
	GamePauseUI.toggle_ui(true)
	DialogueScreen.toggle_ui(true)