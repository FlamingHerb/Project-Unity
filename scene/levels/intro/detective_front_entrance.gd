extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalDatabase.set_flavor_location("Detective's Front Entrance")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_door_input_event(viewport:Node, event:InputEvent, shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		DialogueScreen.init_dialogue("prologue_front_interact", "No Reason")



func _on_left_navigation_pressed():
	SceneManager.goto_level_scene("intro/detective_workshop.tscn")

func _on_right_navigation_pressed():
	SceneManager.goto_level_scene("intro/detective_kitchen.tscn")
