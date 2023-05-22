extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalDatabase.check_switch("door_knocking"):
		$Main/Background.hide()

	GlobalDatabase.set_flavor_location("Kitchen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_left_navigation_pressed():
	SceneManager.goto_level_scene("intro/detective_front_entrance.tscn")

func _on_right_navigation_pressed():
	SceneManager.goto_level_scene("intro/detective_workshop.tscn")


func _on_bathroom_door_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if GlobalDatabase.is_mouse_clicked(event):
		AudioManager.play_sound("opened_door")
		SceneManager.goto_level_scene("intro/detective_bathroom.tscn")
