extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _cutscene():
	$AnimationPlayer.play("cutscene")

func _switch_to_game():
	SceneManager.goto_level_scene("intro/detective_workshop.tscn")
	GamePauseUI.toggle_ui(true)
	DialogueScreen.toggle_ui(true)