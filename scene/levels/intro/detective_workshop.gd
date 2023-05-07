extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalDatabase.set_flavor_location("Detective's Workshop")

	if GlobalDatabase.check_switch("workroom_dialogue") == false:
		DialogueScreen.init_dialogue("prologue_dialogue", "Introduction")
		GlobalDatabase.toggle_switch("workroom_dialogue", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

		

func _on_key_interactable_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Main.hide()
		$TableCloseup.show()


func _on_return_button_pressed():
	$Main.show()
	$TableCloseup.hide()


func _on_worktable_key_pressed():
	Inventory.add_item("Bedroom Key")
	DialogueScreen.init_dialogue("prologue_workroom_interact", "Bedroom Key")
	await DialogueScreen.dialogue_all_finished
	$TableCloseup/WorktableKey.queue_free()
	$Main/Key.queue_free()



func _on_bedroom_door_mouse_exited():
	$Main/BedroomDoor/AnimationPlayer.stop()


func _on_bedroom_door_mouse_entered():
	$Main/BedroomDoor/AnimationPlayer.play("global/door_outline")

func _on_bedroom_door_pressed():
	if Inventory.check_item("Bedroom Key"):
		SceneManager.goto_level_scene("intro/detective_bedroom.tscn")
	else:
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Door Locked")



func _on_radio_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Radio")

func _on_documents_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Pile of Documents")


func _on_bottles_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Bottles of Alcohol")


func _on_blinds_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Main.hide()
		$WindowCloseup.show()


func _on_corkboard_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Corkboard")


func _on_picture_frame_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Picture Frame")


func _on_window_return_button_pressed():
	$Main.show()
	$WindowCloseup.hide()


func _on_blinds_closeup_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Blinds")
