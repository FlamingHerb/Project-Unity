extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalDatabase.set_flavor_location("Bathroom")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_bathroom_door_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if GlobalDatabase.is_mouse_clicked(event):
		SceneManager.goto_level_scene("intro/detective_kitchen.tscn")
