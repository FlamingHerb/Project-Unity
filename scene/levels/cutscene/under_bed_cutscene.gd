extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("under")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if Input.is_action_pressed("ui_accept") or GlobalDatabase.is_mouse_clicked(event):
		if $AnimationPlayer.current_animation_position < 31.5:
			$AnimationPlayer.seek(31.5, true)

func _switch_to_game():
	SceneManager.goto_level_scene("cutscene/news.tscn")