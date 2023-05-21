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

func _switch():
	SceneManager.goto_scene("res://scene/menus/mainmenu.tscn")