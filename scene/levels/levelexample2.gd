extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_closed_door_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if Inventory.check_item("debug_key"):
			SceneManager.goto_scene("res://scene/levels/closedroom.tscn")
		else:
			DialogueScreen.init_dialogue("door_locked")


func _on_open_door_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		SceneManager.goto_scene("res://scene/levels/hallway.tscn")

func _on_key_pressed():
	Inventory.add_item("debug_key")
	DialogueScreen.init_dialogue("example_talk")
	#$Key.queue_free()