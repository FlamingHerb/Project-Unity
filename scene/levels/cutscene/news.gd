extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalDatabase.check_switch("ending_attacked"):
		$AnimationPlayer.play("nanlaban")
	else:
		$AnimationPlayer.play("didntdoanything")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_pressed("ui_accept") or GlobalDatabase.is_mouse_clicked(event):
		if $AnimationPlayer.current_animation_position < 65.5:
			$AnimationPlayer.seek(65.5, true)

func _on_animation_player_animation_finished(_anim_name:StringName):
	SceneManager.goto_level_scene("cutscene/credits.tscn")
