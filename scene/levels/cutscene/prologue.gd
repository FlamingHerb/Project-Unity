extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	_cutscene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if Input.is_action_pressed("ui_accept") or GlobalDatabase.is_mouse_clicked(event):
		if $AnimationPlayer.current_animation_position < 55:
			$AnimationPlayer.seek(55, true)

func _cutscene():
	$AnimationPlayer.play("prologue_cutscene")

func _switch_to_game():
	SceneManager.goto_level_scene("intro/detective_workshop.tscn")
	GamePauseUI.toggle_ui(true)
	DialogueScreen.toggle_ui(true)
