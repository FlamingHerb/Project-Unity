extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalDatabase.check_switch("door_knocking"):
		$Main/Background.hide()
	else:
		AudioManager.play_sound("room")
		
	GlobalDatabase.set_flavor_location("Workshop")
	
	if GlobalDatabase.check_switch("workroom_dialogue") == false:
		DialogueScreen.init_dialogue("prologue_dialogue", "Introduction")
		GlobalDatabase.toggle_switch("workroom_dialogue", true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_key_interactable_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if GlobalDatabase.check_switch("door_knocking"):
		return
	if GlobalDatabase.is_mouse_clicked(event):
		$Main.hide()
		$TableCloseup.show()

func _on_return_button_pressed():
	$Main.show()
	$TableCloseup.hide()


func _on_worktable_key_pressed():
	Inventory.add_item("Bedroom Key")
	AudioManager.play_sound("door_key")
	DialogueScreen.init_dialogue("prologue_workroom_interact", "Bedroom Key")
	await DialogueScreen.dialogue_all_finished
	$TableCloseup/WorktableKey.queue_free()
	$Main/Key.queue_free()

func _on_radio_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if GlobalDatabase.is_mouse_clicked(event):
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Radio")
		AudioManager.play_sound("radio_tune")

func _on_documents_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if GlobalDatabase.is_mouse_clicked(event):
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Pile of Documents")
		AudioManager.play_sound("paper_rustle")


func _on_bottles_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if GlobalDatabase.is_mouse_clicked(event):
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Bottles of Alcohol")
		AudioManager.play_sound("bottle_clink")

func _on_blinds_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if GlobalDatabase.check_switch("door_knocking"):
		return
	if GlobalDatabase.is_mouse_clicked(event):
		$Main.hide()
		$WindowCloseup.show()


func _on_corkboard_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if GlobalDatabase.is_mouse_clicked(event):
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Corkboard")
		AudioManager.play_sound("paper_tear")


func _on_picture_frame_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if GlobalDatabase.is_mouse_clicked(event):
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Picture Frame")


func _on_window_return_button_pressed():
	$Main.show()
	$WindowCloseup.hide()


func _on_blinds_closeup_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if GlobalDatabase.is_mouse_clicked(event):
		DialogueScreen.init_dialogue("prologue_workroom_interact", "Blinds")


func _on_bedroom_door_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if GlobalDatabase.is_mouse_clicked(event):
		if Inventory.check_item("Bedroom Key"):
			AudioManager.play_sound("opened_door")
			SceneManager.goto_level_scene("intro/detective_bedroom.tscn")
		else:
			AudioManager.play_sound("locked_door")
			DialogueScreen.init_dialogue("prologue_workroom_interact", "Door Locked")

func _on_right_navigation_pressed():
	SceneManager.goto_level_scene("intro/detective_front_entrance.tscn")


func _on_left_navigation_pressed():
	SceneManager.goto_level_scene("intro/detective_kitchen.tscn")

func _on_mystery_box_opened_pressed():
	pass # Replace with function body.

func _on_mystery_box_pressed():
	$Main.hide()
	$BoxCloseup.show()

func _on_box_return_button_pressed():
	$Main.show()
	$BoxCloseup.hide()

func _on_box_closeup_mystery_solved():
	$Main.show()
	$BoxCloseup.hide()
	$Main/MysteryBox.hide()
	$Main/MysteryBoxOpened.show()

func _on_letter_return_box_pressed():
	$Main.show()
	$LetterCloseup.hide()

func _on_letter_pressed():
	$Main.hide()
	$LetterCloseup.show()
