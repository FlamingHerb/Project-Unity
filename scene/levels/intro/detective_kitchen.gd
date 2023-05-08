extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalDatabase.set_flavor_location("Detective's Kitchen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_left_navigation_pressed():
	SceneManager.goto_level_scene("intro/detective_front_entrance.tscn")

func _on_right_navigation_pressed():
	SceneManager.goto_level_scene("intro/detective_workshop.tscn")
