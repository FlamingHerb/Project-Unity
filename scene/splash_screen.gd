extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	# if OS.is_debug_build():
	# 	_switch()
	# 	return
	
	$AnimationPlayer.play("splash")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(_event):
	if Input.is_action_pressed("ui_accept"):
		if $AnimationPlayer.current_animation_position < 4.5:
			$AnimationPlayer.seek(4.5, true)
		if $AnimationPlayer.current_animation_position < 12 and $AnimationPlayer.current_animation_position > 4.5:
			$AnimationPlayer.seek(12, true)

func _switch():
	SceneManager.goto_scene("res://scene/menus/mainmenu.tscn")
