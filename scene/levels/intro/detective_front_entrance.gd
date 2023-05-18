extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalDatabase.check_switch("door_knocking"):
		$Main/Background.hide()

	GlobalDatabase.set_flavor_location("Detective's Front Entrance")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_door_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if GlobalDatabase.check_switch("door_knocking"):
			DialogueScreen.init_dialogue("prologue_front_interact", "Door Inspection")
		else:
			DialogueScreen.init_dialogue("prologue_front_interact", "No Reason")
			return


func _on_left_navigation_pressed():
	SceneManager.goto_level_scene("intro/detective_workshop.tscn")

func _on_right_navigation_pressed():
	SceneManager.goto_level_scene("intro/detective_kitchen.tscn")
